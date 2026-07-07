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

        public async Task Create(OrganizationModel model, int userId)
        {
            if (string.IsNullOrWhiteSpace(model.Name))
                throw new Exception("Organization name is required");

            if (string.IsNullOrWhiteSpace(model.Password))
                throw new Exception("Organization password is required");

            string securedPasswordHash = BCrypt.Net.BCrypt.HashPassword(model.Password);
            model.Password = securedPasswordHash;

            await _repo.Create(model, userId);
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