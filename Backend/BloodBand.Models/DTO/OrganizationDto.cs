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

        public int StatusId { get; set; }
        public string? StatusName { get; set; }

        public DateTime? RegistrationDate { get; set; }
        public DateTime? CreatedAt { get; set; }

        public string? LicenseNumber { get; set; }
        public string? LicenseIssuedBy { get; set; }

        public string? CountryName { get; set; }
        public string? StateName { get; set; }
        public string? DistrictName { get; set; }
    }
}