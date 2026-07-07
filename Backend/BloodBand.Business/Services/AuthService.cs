using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using BloodBand.Models;
using System.Security.Cryptography;
using BloodBand.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class AuthService
    {
        private readonly IConfiguration _config;
        private readonly RefreshTokenRepository _repo;
        private readonly UserRepository _userRepo;

        public AuthService(
            IConfiguration config,
            RefreshTokenRepository repo,
            UserRepository userRepo)
        {
            _config = config;
            _repo = repo;
            _userRepo = userRepo;
        }

        public async Task<LoginResponseDto> Refresh(string refreshToken)
        {
            var tokenData = await _repo.GetToken(refreshToken);

            if (tokenData == null || tokenData.Expires < DateTime.Now)
                throw new Exception("Invalid refresh token");

            var user = await _userRepo.GetById(tokenData.UserId);

            if (user == null)
                throw new Exception("User not found");

            var newAccessToken = GenerateToken(user);
            var newRefreshToken = GenerateRefreshToken();

            await _repo.Revoke(refreshToken);

            await _repo.SaveToken(new RefreshTokenModel
            {
                UserId = user.UserId,
                Token = newRefreshToken,
                Expires = DateTime.Now.AddDays(7)
            });

            return new LoginResponseDto
            {
                AccessToken = newAccessToken,
                RefreshToken = newRefreshToken
            };
        }

        public string GenerateToken(UserModel user)
        {
            var jwtKey = _config["Jwt:Key"]
                  ?? throw new Exception("JWT Key is missing");

            var claims = new[]
            {
            new Claim(ClaimTypes.Name, user.FullName ?? ""),
            new Claim("UserId", user.UserId.ToString()),
            new Claim("Phone", user.PhoneNumber ?? ""),
            new Claim(ClaimTypes.Role, user.RoleName ?? "")
        };

            var key = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(jwtKey)
            );

            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: _config["Jwt:Issuer"],
                audience: _config["Jwt:Audience"],
                claims: claims,
                expires: DateTime.Now.AddMinutes(
                    Convert.ToDouble(_config["Jwt:DurationInMinutes"])
                ),
                signingCredentials: creds
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public string GenerateRefreshToken()
        {
            var random = new byte[64];

            using var rng = RandomNumberGenerator.Create();
            rng.GetBytes(random);

            return Convert.ToBase64String(random);
        }
    }
}