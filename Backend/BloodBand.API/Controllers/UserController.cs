using BloodBand.API.Extensions;
using BloodBand.Business.Services;
using BloodBand.Models;
using BloodBand.Models.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BloodBand.API.Controllers
{
    [ApiController]
    [Route("api/user")]
    public class UserController : ControllerBase
    {
        private readonly UserService _service;

        public UserController(UserService service)
        {
            _service = service;
        }

        // ✅ REGISTER
        [HttpPost("register")]
        [ProducesResponseType(typeof(string), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> Register([FromBody] UserModel model)
        {
            await _service.Register(model);
            return Ok("User Registered");
        }

        // ✅ LOGIN
        //[HttpPost("login")]

        //[ProducesResponseType(typeof(LoginResponseDto), StatusCodes.Status200OK)]
        //[ProducesResponseType(StatusCodes.Status400BadRequest)]

        //public async Task<IActionResult> Login([FromBody] LoginDto dto)
        //{
        //    var result = await _service.Login(dto.PhoneNumber);
        //    return Ok(result);
        //}

        //    // ✅ REGULAR USER LOGIN
        //    [HttpPost("login")]
        //    [ProducesResponseType(typeof(LoginResponseDto), StatusCodes.Status200OK)]      
        //    [ProducesResponseType(StatusCodes.Status400BadRequest)]

        //    public async Task<IActionResult> UserLogin([FromBody] UserLoginDto dto)
        //    {
        //        try
        //        {
        //            var result = await _service.UserLogin(dto);
        //            return Ok(result);
        //}
        //        catch (Exception ex)
        //        {
        //            return BadRequest(new { message = ex.Message });
        //        }
        //    }

        //    // ✅ ADMIN & SUPERADMIN LOGIN
        //    [HttpPost("admin-login")]
        //    [ProducesResponseType(typeof(LoginResponseDto), StatusCodes.Status200OK)]    
        //    [ProducesResponseType(StatusCodes.Status400BadRequest)]        
        //    public async Task<IActionResult> AdminLogin([FromBody] AdminLoginDto dto)
        //    {
        //        try
        //        {
        //            var result = await _service.AdminLogin(dto);
        //            return Ok(result);
        //}
        //        catch (Exception ex)
        //        {
        //            return BadRequest(new { message = ex.Message });
        //        }
        //    }

        // ✅ REGULAR USER LOGIN
        [HttpPost("login")]
        [ProducesResponseType(typeof(LoginResponseDto), StatusCodes.Status200OK)]
        
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        
        public async Task<IActionResult> UserLogin([FromBody] UserLoginDto dto)
        {
            try
            {
                var result = await _service.UserLogin(dto);
                return Ok(result); 
    }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        // ✅ ADMIN & SUPERADMIN LOGIN
        [HttpPost("admin-login")]
        [ProducesResponseType(typeof(LoginResponseDto), StatusCodes.Status200OK)]
        
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        
        public async Task<IActionResult> AdminLogin([FromBody] AdminLoginDto dto)
        {
            try
            {
                var result = await _service.AdminLogin(dto);
                return Ok(result); 
    }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }



        // ✅ PROFILE IMAGE
        [Authorize]
        [HttpPost("upload-profile-image")]
        public async Task<IActionResult> UploadProfileImage(IFormFile file)
        {
            if (file == null || file.Length == 0)
                return BadRequest("No file uploaded");

            if (file.Length > 2 * 1024 * 1024)
                return BadRequest("Max file size is 2MB");

            var allowedTypes = new[] { "image/jpeg", "image/png", "image/jpg" };
            if (!allowedTypes.Contains(file.ContentType))
                return BadRequest("Invalid file type");

            var userId = User.GetUserId();

            var oldImage = await _service.GetProfileImage(userId);

            if (!string.IsNullOrEmpty(oldImage))
            {
                var oldPath = Path.Combine(
                    Directory.GetCurrentDirectory(),
                    "wwwroot",
                    oldImage.TrimStart('/')
                );

                if (System.IO.File.Exists(oldPath))
                    System.IO.File.Delete(oldPath);
            }

            var fileName = Guid.NewGuid() + Path.GetExtension(file.FileName);
            var folderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/uploads/profile");

            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            var filePath = Path.Combine(folderPath, fileName);

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }

            var imageUrl = "/uploads/profile/" + fileName;

            await _service.UpdateProfileImage(userId, imageUrl);

            return Ok(new { ImageUrl = imageUrl });
        }
        [Authorize]
        [HttpGet("profile")]

        [ProducesResponseType(typeof(UserProfileDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]

        public async Task<IActionResult> GetProfile()
        {
            var userId = User.GetUserId();

            var data = await _service.GetProfile(userId);

            return Ok(data);
        }
        [Authorize]
        [HttpPost("change-password")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordDto dto)
        {
            var userId = User.GetUserId();

            await _service.ChangePassword(userId, dto);

            return Ok("Password updated successfully");
        }

    }
}
