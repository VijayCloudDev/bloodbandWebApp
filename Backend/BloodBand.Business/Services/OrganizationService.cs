using BloodBand.Data;
using BloodBand.Models;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class OrganizationService
    {
        private readonly OrganizationRepository _repo;

        public OrganizationService(OrganizationRepository repo)
        {
            _repo = repo;
        }

        public async Task Create(OrganizationModel model)
        {
            if (string.IsNullOrWhiteSpace(model.Name))
                throw new Exception("Organization name is required");

            if (string.IsNullOrWhiteSpace(model.Password))
                throw new Exception("Organization password is required");

            if (!model.CountryId.HasValue || model.CountryId <= 0)
                throw new Exception("Country is required");

            if (!model.StateId.HasValue || model.StateId <= 0)
                throw new Exception("State is required");

            if (!model.DistrictId.HasValue || model.DistrictId <= 0)
                throw new Exception("District is required");

            if (string.IsNullOrWhiteSpace(model.PhoneNumber))
                throw new Exception("Phone number is required");

            if (string.IsNullOrWhiteSpace(model.Email))
                throw new Exception("Email is required");

            if (string.IsNullOrWhiteSpace(model.RegistrationNumber))
                throw new Exception("Registration number is required");

            // Hash plaintext password before persistence
            model.Password = BCrypt.Net.BCrypt.HashPassword(model.Password);

            await _repo.Create(model);
        }

        public async Task<IEnumerable<OrganizationDto>> GetAll()
        {
            return await _repo.GetAll();
        }

        public async Task UpdateStatus(int orgId, int statusId)
        {
            if (orgId <= 0)
                throw new Exception("Invalid Organization Id");

            await _repo.UpdateStatus(orgId, statusId);
        }
    }
}
