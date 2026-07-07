using BloodBand.API.Extensions;
using BloodBand.Business.Services;
using BloodBand.Models;
using BloodBand.Models.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BloodBand.API.Controllers
{
    [ApiController]
    [Route("api/request")]
    public class RequestController : ControllerBase
    {
        private readonly RequestService _service;

        public RequestController(RequestService service)
        {
            _service = service;
        }

        // ✅ CREATE
        [Authorize]
        [HttpPost("create")]

        [ProducesResponseType(typeof(string), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]

        public async Task<IActionResult> Create([FromBody] RequestModel model)
        {
            var userId = User.GetUserId();

            model.CreatedBy = userId;

            await _service.Create(model);

            return Ok("Request Created Successfully");
        }

        // ✅ GET ALL
        [Authorize]
        [HttpGet("list")]
        [ProducesResponseType(typeof(IEnumerable<RequestDto>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetAll()
        {
            var data = await _service.GetAll();
            return Ok(data);
        }

        // ✅ GET BY ID
        [Authorize]
        [HttpGet("{id}")]

        [ProducesResponseType(typeof(RequestDetailDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]

        public async Task<IActionResult> GetById(int id)
        {
            var data = await _service.GetById(id);

            if (data == null)
                return NotFound("Request not found");

            return Ok(data);
        }

        // ✅ UPDATE
        [Authorize]
        [HttpPut("update")]
        public async Task<IActionResult> Update([FromBody] RequestModel model)
        {
            var userId = User.GetUserId();

            var existing = await _service.GetById(model.RequestId);

            if (existing == null)
                return NotFound("Request not found");

            if (existing.RequestId != model.RequestId)
                return BadRequest();

            await _service.Update(model);

            return Ok("Request Updated Successfully");
        }

        // ✅ DELETE
        [Authorize]
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _service.Delete(id);

            return Ok("Deleted Successfully");
        }
    }
}