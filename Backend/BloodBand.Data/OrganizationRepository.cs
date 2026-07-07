using Dapper;
using BloodBand.Models;
using System.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Data
{
    public class OrganizationRepository
    {
        private readonly DapperContext _context;

        public OrganizationRepository(DapperContext context)
        {
            _context = context;
        }
        public async Task Create(OrganizationModel model, int userId)
        {
         
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_Organization_Create",
                new
                {
                    model.Name,
                    model.Description,
                    model.CountryId,
                    model.StateId,
                    model.DistrictId,
                    model.Place,
                    model.Pincode,
                    model.PhoneNumber,
                    model.Email,
                    model.RegistrationNumber,
                    model.RegistrationType,
                    model.RegistrationDate,
                    model.LicenseNumber,
                    model.LicenseIssuedBy,
                    PasswordHash = model.Password,
                    CreatedBy = userId,
                    
                },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<OrganizationDto>> GetAll()
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<OrganizationDto>(
                "sp_Organization_GetAll",
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task UpdateStatus(int orgId, int statusId)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_Organization_UpdateStatus",
                new { OrganizationId = orgId, StatusId = statusId },
                commandType: CommandType.StoredProcedure
            );
        }
    }

}
