using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using BloodBand.Business.Services;
using BloodBand.Models.DTO;
using BloodBand.API.Extensions;

[ApiController]
[Route("api/chat")]
public class ChatController : ControllerBase
{
    private readonly ChatService _service;

    public ChatController(ChatService service)
    {
        _service = service;
    }

    //[Authorize]
    //[HttpPost("send")]
    //public async Task<IActionResult> Send(int receiverId, string message)
    //{
    //    var userIdClaim = User.FindFirst("UserId");

    //    if (userIdClaim == null)
    //        return Unauthorized("Invalid token");

    //    int senderId = int.Parse(userIdClaim.Value);

    //    await _service.Send(senderId, receiverId, message);

    //    return Ok("Message Sent");
    //}
    [Authorize]
    [HttpPost("send")]
    public async Task<IActionResult> Send([FromBody] SendMessageDto dto)
    {
        var senderId = int.Parse(User.FindFirst("UserId")!.Value);

        await _service.Send(senderId, dto);

        return Ok("Message Sent");
    }

    [Authorize]
    [HttpGet("history/{userId}")]
    public async Task<IActionResult> Get()
    {
        var userId = User.GetUserId();

        var data = await _service.Get(userId, userId);

        return Ok(data);
    }
}
