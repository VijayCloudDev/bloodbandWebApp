using BloodBand.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class NotificationService
    {
        private readonly NotificationRepository _repo;

        public NotificationService(NotificationRepository repo)
        {
            _repo = repo;
        }

        public async Task<IEnumerable<NotificationDto>> GetAll(int userId)
        {
            return await _repo.GetAll(userId);
        }

        public async Task MarkAsRead(int id, int userId)
        {
            var success = await _repo.MarkAsRead(id, userId);


            if (!success)
                throw new UnauthorizedAccessException("Invalid notification access");

        }
    }
}
