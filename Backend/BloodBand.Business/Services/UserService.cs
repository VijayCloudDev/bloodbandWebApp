using BloodBand.Data;
using BloodBand.Models;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class UserService
    {
        private readonly UserRepository _repo;
        private readonly AuthService _auth;
        private readonly RefreshTokenRepository _refreshRepo;
        public UserService(UserRepository repo, AuthService auth, RefreshTokenRepository refreshRepo)
        {
            _repo = repo;
            _auth = auth;
            _refreshRepo = refreshRepo;
        }

        //public async Task Register(UserModel model)
        //{
        //    if (string.IsNullOrWhiteSpace(model.FullName))
        //        throw new Exception("Full name required");

        //    if (string.IsNullOrWhiteSpace(model.PhoneNumber))
        //        throw new Exception("Phone required");

        //    if (model.BloodGroupId <= 0)
        //        throw new Exception("Invalid Blood Group");

        //    await _repo.Register(model);
        //}
        public async Task Register(UserModel model)
        {
            if (string.IsNullOrWhiteSpace(model.FullName)) 
                throw new Exception("Full name required");

            if (string.IsNullOrWhiteSpace(model.PhoneNumber))
                throw new Exception("Phone required");

            if (string.IsNullOrWhiteSpace(model.PasswordHash))
                throw new Exception("Password required");

            if (model.BloodGroupId <= 0)
                throw new Exception("Invalid Blood Group");

            // Securely hash the password before sending it to repository/DB
            model.PasswordHash = BCrypt.Net.BCrypt.HashPassword(model.PasswordHash);

            await _repo.Register(model);
        }



        //public async Task<UserModel?> Login(string phone)
        //{
        //    var user = await _repo.Login(phone);

        //    if (user == null)
        //        throw new Exception("Invalid user");

        //    var accessToken = _auth.GenerateToken(user);
        //    var refreshToken = _auth.GenerateRefreshToken();

        //    await _refreshRepo.SaveToken(new RefreshTokenModel
        //    {
        //        UserId = user.UserId,
        //        Token = refreshToken,
        //        Expires = DateTime.Now.AddDays(7)
        //    });

        //    return new
        //    {
        //        AccessToken = accessToken,
        //        RefreshToken = refreshToken
        //    };
        //}
        //public async Task<LoginResponseDto> Login(string phone)
        //{
        //    var user = await _repo.Login(phone);

        //    if (user == null)
        //        throw new Exception("Invalid user");

        //    var accessToken = _auth.GenerateToken(user);
        //    var refreshToken = _auth.GenerateRefreshToken();

        //    await _refreshRepo.SaveToken(new RefreshTokenModel
        //    {
        //        UserId = user.UserId,
        //        Token = refreshToken,
        //        Expires = DateTime.Now.AddDays(7)
        //    });

        //    return new LoginResponseDto
        //    {
        //        AccessToken = accessToken,
        //        RefreshToken = refreshToken
        //    };
        //}

        //public async Task<LoginResponseDto> UserLogin(UserLoginDto dto)
        //{
        //    if (string.IsNullOrWhiteSpace(dto.PhoneNumber) || string.IsNullOrWhiteSpace(dto.Password))
        //        throw new Exception("Phone number and password are required.");

        //    var user = await _repo.UserLogin(dto);
        //    if (user == null)
        //        throw new Exception("Invalid phone number or password.");

        //    return await GenerateLoginSession(user);
        //}

        //public async Task<LoginResponseDto> AdminLogin(AdminLoginDto dto)
        //{
        //    if (string.IsNullOrWhiteSpace(dto.Email) || string.IsNullOrWhiteSpace(dto.Password))
        //        throw new Exception("Email and password are required.");

        //    var user = await _repo.AdminLogin(dto);
        //    if (user == null)
        //        throw new Exception("Invalid email or password.");

        //    return await GenerateLoginSession(user);
        //}

        //// Helper logic to reduce code duplication
        //private async Task<LoginResponseDto> GenerateLoginSession(UserModel user)
        //{
        //    var accessToken = _auth.GenerateToken(user);
        //    var refreshToken = _auth.GenerateRefreshToken();

        //    await _refreshRepo.SaveToken(new RefreshTokenModel
        //    {
        //        UserId = user.UserId,
        //        Token = refreshToken,
        //        Expires = DateTime.Now.AddDays(7)
        //    });

        //    return new LoginResponseDto
        //    {
        //        AccessToken = accessToken,
        //        RefreshToken = refreshToken
        //    };
        //}

        public async Task<LoginResponseDto> UserLogin(UserLoginDto dto)
        {
            if (string.IsNullOrWhiteSpace(dto.PhoneNumber) || string.IsNullOrWhiteSpace(dto.Password))
                throw new Exception("Phone number and password are required.");

            var user = await _repo.GetUserForLogin(dto.PhoneNumber, null, "User");
            if (user == null || string.IsNullOrEmpty(user.PasswordHash))
                throw new Exception("Invalid credentials.");

            // Verify the entered text password against the hashed string from DB
            bool isPasswordValid = BCrypt.Net.BCrypt.Verify(dto.Password, user.PasswordHash);
            if (!isPasswordValid)
                throw new Exception("Invalid credentials.");

            return await GenerateLoginSession(user);
        }

        // ✅ ADMIN LOGIN WITH BCRYPT VERIFY
        public async Task<LoginResponseDto> AdminLogin(AdminLoginDto dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Email) || string.IsNullOrWhiteSpace(dto.Password))
                throw new Exception("Email and password are required.");

            var user = await _repo.GetUserForLogin(null, dto.Email, "Admin");
            if (user == null || string.IsNullOrEmpty(user.PasswordHash))
                throw new Exception("Invalid credentials.");

            // Verify the entered text password against the hashed string from DB
            bool isPasswordValid = BCrypt.Net.BCrypt.Verify(dto.Password, user.PasswordHash);
            if (!isPasswordValid)
                throw new Exception("Invalid credentials.");

            return await GenerateLoginSession(user);
        }

        private async Task<LoginResponseDto> GenerateLoginSession(UserModel user)
        {
            var accessToken = _auth.GenerateToken(user); 
            var refreshToken = _auth.GenerateRefreshToken(); 

            await _refreshRepo.SaveToken(new RefreshTokenModel
            {
                UserId = user.UserId,
                Token = refreshToken,
                Expires = DateTime.Now.AddDays(7)
            });

            return new LoginResponseDto
            {
                AccessToken = accessToken,
                RefreshToken = refreshToken
            };
        }



        public async Task UpdateProfileImage(int userId, string imageUrl)
        {
            await _repo.UpdateProfileImage(userId, imageUrl);
        }
        public async Task<string?> GetProfileImage(int userId)
        {
            return await _repo.GetProfileImage(userId);
        }

        public async Task<UserModel?> GetById(int userId)
        {
            return await _repo.GetById(userId);
        }
        public async Task<UserProfileDto?> GetProfile(int userId)
        {
            return await _repo.GetProfile(userId);
        }
        public async Task ChangePassword(int userId, ChangePasswordDto dto)
        {
            if (string.IsNullOrWhiteSpace(dto.OldPasswordHash))
                throw new Exception("Old password required");

            if (string.IsNullOrWhiteSpace(dto.NewPasswordHash))
                throw new Exception("New password required");

            await _repo.ChangePassword(userId, dto.OldPasswordHash, dto.NewPasswordHash);
        }

    }
}
