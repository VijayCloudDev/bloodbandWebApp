using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using BloodBand.Business.Services;
using BloodBand.API.Extensions;
using BloodBand.Models.DTO;

[ApiController]
[Route("api/dashboard")]
public class DashboardController : ControllerBase
{
    private readonly DashboardService _service;

    public DashboardController(DashboardService service)
    {
        _service = service;
    }

    [Authorize]
    [HttpGet]
    [ProducesResponseType(typeof(DashboardDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> Get()
    {
        var userId = User.GetUserId();

        var data = await _service.GetDashboard(userId);

        return Ok(data);
    }
}
