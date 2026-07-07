using BloodBand.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class AdService
    {
        private readonly AdRepository _repo;

        public AdService(AdRepository repo)
        {
            _repo = repo;
        }

        public async Task Create(CreateAdDto dto, int userId )
        {
            if (string.IsNullOrWhiteSpace(dto.Title))
                throw new Exception("Title is required");

            if (string.IsNullOrWhiteSpace(dto.ImageUrl))
                throw new Exception("Image URL is required");

            await _repo.Create(dto, userId);
        }

        public async Task<IEnumerable<AdDto>> GetActive()
        {
            return await _repo.GetActive();
        }

        public async Task ChangeStatus(int adId, bool isActive)
        {
            await _repo.UpdateStatus(adId, isActive);
        }
    }
}