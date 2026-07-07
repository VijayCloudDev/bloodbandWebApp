using Dapper;
using System.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Data
{
    public class SearchRepository
    {
        private readonly DapperContext _context;

        public SearchRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<DonorDto>> FindDonors(int bloodGroupId, int? districtId)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<DonorDto>(
                "sp_Search_Donors",
                new
                {
                    BloodGroupId = bloodGroupId,
                    DistrictId = districtId
                },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<OrganizationDto>> GetOrganizations()
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<OrganizationDto>(
                "sp_Search_Organizations",
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<HospitalDto>> GetHospitals()
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<HospitalDto>(
                "sp_Search_Hospitals",
                commandType: CommandType.StoredProcedure
            );
        }
    }
}