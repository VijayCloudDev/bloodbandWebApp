namespace BloodBand.Models.DTO
{
    // For regular users (Phone + Password)
    public class UserLoginDto
    {
        public string PhoneNumber { get; set; } = "";
        public string Password { get; set; } = "";
    }

    // For internal administrators (Email + Password)
    public class AdminLoginDto
    {
        public string Email { get; set; } = "";
        public string Password { get; set; } = "";
    }
}