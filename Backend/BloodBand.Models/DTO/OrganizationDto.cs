namespace BloodBand.Models.DTO
{
    public class OrganizationDto
    {
        public int OrganizationId { get; set; }

        public string Name { get; set; } = "";
        public string? Description { get; set; }

        public string? Place { get; set; }
        public string? Pincode { get; set; }

        public string? PhoneNumber { get; set; }
        public string? Email { get; set; }

        public string? RegistrationNumber { get; set; }
        public string? RegistrationType { get; set; }

        public bool IsVerified { get; set; }

        public string? CountryName { get; set; }
        public string? StateName { get; set; }
        public string? DistrictName { get; set; }
    }
}