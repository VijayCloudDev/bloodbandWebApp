using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using BloodBand.Business.Services;
using BloodBand.Models;

namespace BloodBand.API.Controllers
{
    [ApiController]
    [Route("api/org")]
    public class OrganizationController : ControllerBase
    {
        private readonly OrganizationService _service;

        public OrganizationController(OrganizationService service)
        {
            _service = service;
        }

        /// <summary>
        /// Public organization self-registration (creates org + manager user).
        /// </summary>
        [AllowAnonymous]
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] OrganizationModel model)
        {
            try
            {
                await _service.Create(model);
                return Ok(new { message = "Organization Registration Submitted Successfully" });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        /// <summary>
        /// Organization directory for SuperAdmin review. Optional statusId filter (1 Pending, 2 Approved, 3 Rejected).
        /// </summary>
        [Authorize(Roles = "SuperAdmin")]
        [HttpGet("list")]
        public async Task<IActionResult> GetAll([FromQuery] int? statusId = null)
        {
            var data = await _service.GetAll(statusId);
            return Ok(data);
        }

        [Authorize(Roles = "SuperAdmin")]
        [HttpPut("status")]
        public async Task<IActionResult> ChangeStatus([FromQuery] int orgId, [FromQuery] int statusId)
        {
            try
            {
                await _service.UpdateStatus(orgId, statusId);
                return Ok(new { message = "Organization status updated" });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}
