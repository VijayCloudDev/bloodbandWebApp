using Dapper;
using System.Data;
using BloodBand.Models;

namespace BloodBand.Data
{
    public class RefreshTokenRepository
    {
        private readonly DapperContext _context;

        public RefreshTokenRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task SaveToken(RefreshTokenModel model)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_RefreshToken_Save",
                new
                {
                    UserId = model.UserId,
                    Token = model.Token,
                    Expires = model.Expires
                },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<RefreshTokenModel?> GetToken(string token)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryFirstOrDefaultAsync<RefreshTokenModel>(
                "sp_RefreshToken_Get",
                new { Token = token },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task Revoke(string token)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_RefreshToken_Revoke",
                new { Token = token },
                commandType: CommandType.StoredProcedure
            );
        }
    }
}