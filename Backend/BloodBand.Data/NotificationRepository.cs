using BloodBand.Models.DTO;
using Dapper;
using System.Data;

namespace BloodBand.Data
{
    public class NotificationRepository
    {
        private readonly DapperContext _context;

        public NotificationRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<NotificationDto>> GetAll(int userId)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<NotificationDto>(
                "sp_Notification_GetAll",
                new { UserId = userId },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task MarkAsRead(int id)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_Notification_Read",
                new { NotificationId = id },
                commandType: CommandType.StoredProcedure
            );
        }
        public async Task<bool> MarkAsRead(int id, int userId)
        {
            using var conn = _context.CreateConnection();

            var affected = await conn.ExecuteScalarAsync<int>(
                "sp_Notification_Read",
                new { NotificationId = id, UserId = userId },
                commandType: CommandType.StoredProcedure
            );

            return affected > 0;
        }
    }
}