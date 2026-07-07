using BloodBand.Data;
using BloodBand.Models;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class RequestService
    {
        private readonly RequestRepository _repo;

        public RequestService(RequestRepository repo)
        {
            _repo = repo;
        }

        public async Task Create(RequestModel model)
        {
            if (string.IsNullOrWhiteSpace(model.PatientName))
                throw new Exception("Patient name is required");

            if (model.BloodGroupId <= 0)
                throw new Exception("Invalid Blood Group");

            await _repo.Create(model);
        }

        public async Task<IEnumerable<RequestDto>> GetAll()
        {
            return await _repo.GetAll();
        }

        public async Task<RequestDetailDto?> GetById(int id)
        {
            return await _repo.GetById(id);
        }

        public async Task Update(RequestModel model)
        {
            if (model.RequestId <= 0)
                throw new Exception("Invalid Request Id");

            if (string.IsNullOrWhiteSpace(model.PatientName))
                throw new Exception("Patient Name is required");

            await _repo.Update(model);
        }

        public async Task Delete(int id)
        {
            await _repo.Delete(id);
        }
    }
}