using BloodBand.Business.Services;
using BloodBand.Data;
using BloodBand.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BloodBand.API.Controllers
{
    [ApiController]
    [Route("api/auth")]
    public class AuthController : ControllerBase
    { 
        private readonly AuthService _auth;

        public AuthController(AuthService auth)
        {
            _auth = auth;
        }

        //[HttpPost("refresh")]
        //public async Task<IActionResult> Refresh(string refreshToken)
        //{

        //    var result = await _auth.Refresh(refreshToken);
        //    return Ok(result);

        //var tokenData = await _repo.GetToken(refreshToken);

        //if (tokenData == null || tokenData.Expires < DateTime.Now)
        //    return Unauthorized("Invalid refresh token");

        //var user = await _userRepo.LoginById(tokenData.UserId);


        //if (user == null)
        //    return Unauthorized("User not found");


        //var newAccessToken = _auth.GenerateToken(user);
        //var newRefreshToken = _auth.GenerateRefreshToken();

        //await _repo.Revoke(refreshToken);

        //await _repo.SaveToken(new RefreshTokenModel
        //{
        //    UserId = user.UserId,
        //    Token = newRefreshToken,
        //    Expires = DateTime.Now.AddDays(7)
        //});

        //return Ok(new
        //{
        //    AccessToken = newAccessToken,
        //    RefreshToken = newRefreshToken
        //});
        //}

        [HttpPost("refresh")]
        public async Task<IActionResult> Refresh([FromBody] string refreshToken)
        {
            var result = await _auth.Refresh(refreshToken);
            return Ok(result);
        }


    }
}
