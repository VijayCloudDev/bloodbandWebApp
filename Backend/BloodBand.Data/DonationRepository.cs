using BloodBand.Models.DTO;
using Dapper;
using System.Data;

namespace BloodBand.Data
{
    public class DonationRepository
    {
        private readonly DapperContext _context;

        public DonationRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task Accept(int requestId, int donorId)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync("sp_Donation_Accept",
                new { RequestId = requestId, DonorId = donorId },
                commandType: CommandType.StoredProcedure);
        }

        public async Task Complete(int donationId)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                    "sp_Donation_Complete",
                    new { DonationId = donationId },
                    commandType: CommandType.StoredProcedure
                 );
        }
        public async Task<IEnumerable<DonationDto>> GetByUser(int userId)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<DonationDto>(
                "sp_Donation_GetByUser",
                new { UserId = userId },
                commandType: CommandType.StoredProcedure
            );
        }

    }
}