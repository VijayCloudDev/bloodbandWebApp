using BloodBand.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class SearchService
    {
        private readonly SearchRepository _repo;

        public SearchService(SearchRepository repo)
        {
            _repo = repo;
        }

        public async Task<IEnumerable<DonorDto>> FindDonors(int bloodGroupId, int districtId)
        {
            if (bloodGroupId <= 0)
                throw new Exception("Invalid Blood Group");

            return await _repo.FindDonors(bloodGroupId, districtId);
        }

        public async Task<IEnumerable<OrganizationDto>> GetOrganizations()
        {
            return await _repo.GetOrganizations();
        }

        public async Task<IEnumerable<HospitalDto>> GetHospitals()
        {
            return await _repo.GetHospitals();
        }
    }
}
