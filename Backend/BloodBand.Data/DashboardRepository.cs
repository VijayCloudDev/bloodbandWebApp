using BloodBand.Models.DTO;
using Dapper;
using System.Data;

namespace BloodBand.Data
{
    public class DashboardRepository
    {
        private readonly DapperContext _context;

        public DashboardRepository(DapperContext context)
        {
            _context = context;
        }


        public async Task<DashboardDto> GetDashboard(int userId)
        {
            using var conn = _context.CreateConnection();

            using var multi = await conn.QueryMultipleAsync(
                "sp_Dashboard_Get",
                new { UserId = userId },
                commandType: CommandType.StoredProcedure
            );

            var result = new DashboardDto();

            result.Summary.TotalRequests = await multi.ReadFirstAsync<int>();
            result.Summary.MyDonations = await multi.ReadFirstAsync<int>();
            result.Summary.PendingRequests = await multi.ReadFirstAsync<int>();
            result.RecentRequests = (await multi.ReadAsync<RequestDto>()).ToList();
            result.Notifications = (await multi.ReadAsync<NotificationDto>()).ToList();
            result.Summary.TotalOrganizations = await multi.ReadFirstAsync<int>();
            return result;
        }

    }
}