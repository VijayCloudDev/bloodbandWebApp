using BloodBand.Business.Services;
using BloodBand.Models.DTO;
using Microsoft.AspNetCore.Mvc;

namespace BloodBand.API.Controllers
{
    [ApiController]
    [Route("api/common")]
    public class CommonController : ControllerBase
    {
        private readonly CommonService _service;

        public CommonController(CommonService service)
        {
            _service = service;
        }

        [HttpGet("registration-types")]
        [ProducesResponseType(typeof(IEnumerable<LookupDto>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetRegistrationTypes()
        {
            var data = await _service.GetRegistrationTypes();

            return Ok(data);
        }

        [HttpGet("countries")]
        [ProducesResponseType(typeof(IEnumerable<LookupDto>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetCountries()
        {
            var data = await _service.GetCountries();

            return Ok(data);
        }

        [HttpGet("states/{countryId:int}")]
        [ProducesResponseType(typeof(IEnumerable<LookupDto>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetStates(int countryId)
        {
            var data = await _service.GetStates(countryId);

            return Ok(data);
        }

        [HttpGet("districts/{stateId:int}")]
        [ProducesResponseType(typeof(IEnumerable<LookupDto>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetDistricts(int stateId)
        {
            var data = await _service.GetDistricts(stateId);

            return Ok(data);
        }
    }
}