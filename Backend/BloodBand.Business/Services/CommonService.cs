using BloodBand.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class CommonService
    {
        private readonly CommonRepository _repo;

        public CommonService(CommonRepository repo)
        {
            _repo = repo;
        }

        public async Task<IEnumerable<LookupDto>> GetRegistrationTypes()
        {
            return await _repo.GetRegistrationTypes();
        }

        public async Task<IEnumerable<LookupDto>> GetCountries()
        {
            return await _repo.GetCountries();
        }

        public async Task<IEnumerable<LookupDto>> GetStates(int countryId)
        {
            return await _repo.GetStates(countryId);
        }

        public async Task<IEnumerable<LookupDto>> GetDistricts(int stateId)
        {
            return await _repo.GetDistricts(stateId);
        }
    }
}