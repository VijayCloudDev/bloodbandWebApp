using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using BloodBand.Business.Services;
using BloodBand.API.Extensions;
using BloodBand.Models.DTO;

[ApiController]
[Route("api/notification")]
public class NotificationController : ControllerBase
{
    private readonly NotificationService _service;

    public NotificationController(NotificationService service)
    {
        _service = service;
    }

    [Authorize]
    [HttpGet]
    [ProducesResponseType(typeof(IEnumerable<NotificationDto>), StatusCodes.Status200OK)]
    public async Task<IActionResult> Get()
    {
        var userId = User.GetUserId();
        var data = await _service.GetAll(userId);
        return Ok(data);
    }

    [Authorize]
    [HttpPut("read/{id}")]
    public async Task<IActionResult> MarkRead(int id)
    {
        var userId = User.GetUserId();
        await _service.MarkAsRead(id, userId);
        return Ok("Marked as read");
    }
}