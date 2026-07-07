namespace BloodBand.Models.DTO
{
    public class HospitalDto
    {
        public int HospitalId { get; set; }
        public string Name { get; set; } = "";
        public string District { get; set; } = "";
        public string State { get; set; } = "";
        public string ContactNumber { get; set; } = "";
    }
}