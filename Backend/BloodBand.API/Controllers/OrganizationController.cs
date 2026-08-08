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

        [Authorize]
        [HttpGet("list")]
        public async Task<IActionResult> GetAll()
        {
            var data = await _service.GetAll();
            return Ok(data);
        }

        [Authorize(Roles = "SuperAdmin")]
        [HttpPut("status")]
        public async Task<IActionResult> ChangeStatus(int orgId, int statusId)
        {
            await _service.UpdateStatus(orgId, statusId);
            return Ok("Updated");
        }
    }
}
