using BloodBand.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class DonationService
    {
        private readonly DonationRepository _repo;

        public DonationService(DonationRepository repo)
        {
            _repo = repo;
        }

        public async Task Complete(int donationId)
        {
            if (donationId <= 0)
                throw new Exception("Invalid Donation Id");

            await _repo.Complete(donationId);
        }

        public async Task Accept(int requestId, int donorId)
        {
            if (requestId <= 0)
                throw new Exception("Invalid request Id");

            if (donorId <= 0)
                throw new Exception("Invalid donor Id");

            await _repo.Accept(requestId, donorId);
        }
        public async Task<IEnumerable<DonationDto>> GetMyDonations(int userId)
        {
            return await _repo.GetByUser(userId);
        }

    }
}
