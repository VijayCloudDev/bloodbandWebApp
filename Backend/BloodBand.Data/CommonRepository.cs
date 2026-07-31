using Dapper;
using BloodBand.Models.DTO;
using System.Data;

namespace BloodBand.Data
{
    public class CommonRepository
    {
        private readonly DapperContext _context;

        public CommonRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<LookupDto>> GetRegistrationTypes()
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<LookupDto>(
                "sp_Common_GetRegistrationTypes",
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<LookupDto>> GetCountries()
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<LookupDto>(
                "sp_Common_GetCountries",
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<LookupDto>> GetStates(int countryId)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<LookupDto>(
                "sp_Common_GetStatesByCountryId",
                new { CountryId = countryId },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<LookupDto>> GetDistricts(int stateId)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<LookupDto>(
                "sp_Common_GetDistrictsByStateId",
                new { StateId = stateId },
                commandType: CommandType.StoredProcedure
            );
        }
    }
}