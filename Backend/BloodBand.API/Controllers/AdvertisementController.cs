using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using BloodBand.Business.Services;
using BloodBand.Models.DTO;
using BloodBand.API.Extensions;

[ApiController]
[Route("api/advertise")]
public class AdvertisementController : ControllerBase
{
    private readonly AdService _service;

    public AdvertisementController(AdService service)
    {
        _service = service;
    }

    [Authorize(Roles = "SuperAdmin")]
    [HttpPost("create")]
    public async Task<IActionResult> Create([FromBody] CreateAdDto dto)
    {

        var userId = User.GetUserId();

        await _service.Create(dto, userId);

        return Ok("Ad Created");
    }

    [HttpGet("active")]
    public async Task<IActionResult> GetActive()
    {
        var ads = await _service.GetActive();
        return Ok(ads);
    }

    [Authorize(Roles = "SuperAdmin")]
    [HttpPut("status")]
    public async Task<IActionResult> ChangeStatus(int adId, bool isActive)
    {
        await _service.ChangeStatus(adId, isActive);
        return Ok("Updated");
    }
}