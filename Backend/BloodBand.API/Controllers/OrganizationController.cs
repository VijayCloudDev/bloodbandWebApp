using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using BloodBand.Business.Services;
using BloodBand.Models;
using BloodBand.API.Extensions;

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

        // ✅ CREATE
        [Authorize]
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] OrganizationModel model)
        {
            var userId = User.GetUserId();

            await _service.Create(model, userId);

            return Ok(new { message = "Organization Registration Submitted Successfully" });
        }

        // ✅ GET ALL
        [Authorize]
        [HttpGet("list")]
        public async Task<IActionResult> GetAll()
        {
            var data = await _service.GetAll();

            return Ok(data);
        }

        // ✅ UPDATE STATUS (ADMIN)
        [Authorize(Roles = "SuperAdmin")]
        [HttpPut("status")]
        public async Task<IActionResult> ChangeStatus(int orgId, int statusId)
        {
            await _service.UpdateStatus(orgId, statusId);

            return Ok("Updated");
        }
    }
}