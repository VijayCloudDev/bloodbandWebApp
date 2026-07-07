using Dapper;
using BloodBand.Models;
using System.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Data
{
    public class UserRepository
    {
        private readonly DapperContext _context;

        public UserRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task Register(UserModel model)
        {
            var p = new DynamicParameters();
            p.Add("@FullName", model.FullName);
            p.Add("@PhoneNumber", model.PhoneNumber);
            p.Add("@Email", model.Email);
            p.Add("@PasswordHash", model.PasswordHash);
            p.Add("@BloodGroupId", model.BloodGroupId);
            p.Add("@Gender", model.Gender);
            p.Add("@RoleId", model.RoleId);

            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync("sp_User_Register",
                p, commandType: CommandType.StoredProcedure);
        }

        //public async Task<UserModel?> Login(string phone)
        //{
        //    using var conn = _context.CreateConnection();

        //    return await conn.QueryFirstOrDefaultAsync<UserModel>(
        //        "sp_User_Login",
        //        new { PhoneNumber = phone },
        //        commandType: CommandType.StoredProcedure
        //    );
        //}

        //    public async Task<UserModel?> UserLogin(UserLoginDto dto)
        //    {
        //        using var conn = _context.CreateConnection();

        //        return await conn.QueryFirstOrDefaultAsync<UserModel>(
        //            "sp_User_Login",
        //            new
        //            {
        //                PhoneNumber = dto.PhoneNumber,
        //                PasswordHash = dto.Password, // Replace with your password hashing method if applicable
        //                LoginType = "User"
        //            },
        //            commandType: CommandType.StoredProcedure
        //        );
        //    }

        //    public async Task<UserModel?> AdminLogin(AdminLoginDto dto)
        //    {
        //        using var conn = _context.CreateConnection(); 

        //return await conn.QueryFirstOrDefaultAsync<UserModel>(
        //    "sp_User_Login",
        //    new
        //    {
        //        Email = dto.Email,
        //        PasswordHash = dto.Password, // Replace with your password hashing method if applicable
        //        LoginType = "Admin"
        //    },
        //    commandType: CommandType.StoredProcedure
        //);
        //    }

        public async Task<UserModel?> GetUserForLogin(string? phone, string? email, string loginType)
        {
            using var conn = _context.CreateConnection(); 

    return await conn.QueryFirstOrDefaultAsync<UserModel>(
        "sp_User_Login",
        new
        {
            PhoneNumber = phone,
            Email = email,
            LoginType = loginType
        },
        commandType: CommandType.StoredProcedure
    );
        }

        public async Task<UserModel?> GetById(int userId)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryFirstOrDefaultAsync<UserModel>(
                "sp_User_GetById",
                new { UserId = userId },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task UpdateProfileImage(int userId, string imageUrl)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_User_UpdateProfileImage",
                new { UserId = userId, ProfileImageUrl = imageUrl },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<string?> GetProfileImage(int userId)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryFirstOrDefaultAsync<string>(
                "sp_User_GetProfileImage",
                new { UserId = userId },
                commandType: CommandType.StoredProcedure
            );
        }
        public async Task<UserProfileDto?> GetProfile(int userId)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryFirstOrDefaultAsync<UserProfileDto>(
                "sp_User_GetProfile",
                new { UserId = userId },
                commandType: CommandType.StoredProcedure
            );
        }
        public async Task ChangePassword(int userId, string oldPassword, string newPassword)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_User_ChangePassword",
                new
                {
                    UserId = userId,
                    OldPasswordHash = oldPassword,
                    NewPasswordHash = newPassword
                },
                commandType: CommandType.StoredProcedure
            );
        }
    }
}