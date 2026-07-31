namespace BloodBand.Models.DTO
{
    /// <summary>
    /// Generic lookup row for common master-data endpoints.
    /// </summary>
    public class LookupDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = "";

        public int CountryId { get; set; }
        public string CountryName { get; set; } = "";

        public int StateId { get; set; }
        public string StateName { get; set; } = "";

        public int DistrictId { get; set; }
        public string DistrictName { get; set; } = "";
    }
}
