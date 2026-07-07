using BloodBand.API.Extensions;
using BloodBand.Business.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BloodBand.API.Controllers
{
    [ApiController]
    [Route("api/donation")]
    public class DonationController : ControllerBase
    {
        private readonly DonationService _service;

        public DonationController(DonationService service)
        {
            _service = service;
        }


        [Authorize(Roles = "Donor")]
        [HttpPost("accept")]

        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]

        public async Task<IActionResult> Accept(int requestId)
        {
            var donorId = User.GetUserId();
            await _service.Accept(requestId, donorId);
            return Ok("Accepted");
        }

        [Authorize]
        [HttpPut("complete")]
        public async Task<IActionResult> Complete(int donationId)
        {
            await _service.Complete(donationId);
            return Ok("Completed");
        }
        [Authorize]
        [HttpGet("my")]
        public async Task<IActionResult> GetMyDonations()
        {
            var userId = User.GetUserId();

            var data = await _service.GetMyDonations(userId);

            return Ok(data);
        }

    }
}
