namespace BloodBand.Models.DTO
{
    public class DonorDto
    {
        public int UserId { get; set; }
        public string FullName { get; set; } = "";
        public string PhoneNumber { get; set; } = "";

        public string BloodGroupName { get; set; } = "";
        public string DistrictName { get; set; } = "";
        public string StateName { get; set; } = "";
    }
}