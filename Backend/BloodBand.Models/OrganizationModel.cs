namespace BloodBand.Models
{
    public class OrganizationModel
    {
        public string? Name { get; set; }
        public string? Description { get; set; }

        public int? CountryId { get; set; }
        public int? StateId { get; set; }
        public int? DistrictId { get; set; }

        public string? Place { get; set; }
        public string? Pincode { get; set; }

        public string? PhoneNumber { get; set; }
        public string? Email { get; set; }

        public string? RegistrationNumber { get; set; }
        public string? RegistrationType { get; set; }
        public DateTime? RegistrationDate { get; set; }

        public string? LicenseNumber { get; set; }
        public string? LicenseIssuedBy { get; set; }
        public string? Password { get; set; }
    }
}