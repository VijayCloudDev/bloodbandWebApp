using BloodBand.Models.DTO;
using Dapper;
using System.Data;

namespace BloodBand.Data
{
    public class AdRepository
    {
        private readonly DapperContext _context;

        public AdRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task Create(CreateAdDto dto, int userId)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
    "sp_Ad_Create",
    new
    {
        dto.Title,
        dto.ImageUrl,
        dto.RedirectUrl,
        CreatedBy = userId

    },
    commandType: CommandType.StoredProcedure
);
        }

        public async Task<IEnumerable<AdDto>> GetActive()
        {
            using var conn = _context.CreateConnection();
            return await conn.QueryAsync<AdDto>(
                "sp_Ad_GetActive",
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task UpdateStatus(int adId, bool isActive)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
    "sp_Ad_UpdateStatus",
    new { AdId = adId, IsActive = isActive },
     commandType: CommandType.StoredProcedure
            );
        }
    }
}