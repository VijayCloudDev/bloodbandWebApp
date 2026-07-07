using BloodBand.Business.Services;
using BloodBand.Models.DTO;
using Microsoft.AspNetCore.Mvc;

namespace BloodBand.API.Controllers
{
    [ApiController]
    [Route("api/search")]
    public class SearchController : ControllerBase
    {
        private readonly SearchService _service;

        public SearchController(SearchService service)
        {
            _service = service;
        }

        // ✅ Donor Search
        [HttpGet("donors")]
        [ProducesResponseType(typeof(IEnumerable<DonorDto>), StatusCodes.Status200OK)]
        public async Task<IActionResult> Donors(int bloodGroupId, int districtId)
        {
            var data = await _service.FindDonors(bloodGroupId, districtId);
            return Ok(data);
        }

        // ✅ Organizations
        [HttpGet("org")]
        public async Task<IActionResult> Org()
        {
            return Ok(await _service.GetOrganizations());
        }

        // ✅ Hospitals
        [HttpGet("hospitals")]
        public async Task<IActionResult> Hospitals()
        {
            return Ok(await _service.GetHospitals());
        }
    }
}