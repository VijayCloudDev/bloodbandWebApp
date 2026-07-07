namespace BloodBand.Models
{
    public class RequestModel
    {
        public int RequestId { get; set; }
        public int CreatedBy { get; set; }

        public string PatientName { get; set; } = string.Empty;

        public int BloodGroupId { get; set; }

        public int UnitsNeeded { get; set; }

        public string State { get; set; } = string.Empty;
        public string District { get; set; } = string.Empty;

        public string HospitalName { get; set; } = string.Empty;
        public string Place { get; set; } = string.Empty;

        public string Description { get; set; } = string.Empty;

        public DateTime RequestDate { get; set; }
        public string RequestTime { get; set; } = string.Empty;
    }
}
