namespace BloodBand.Models.DTO
{
    /// <summary>
    /// Generic lookup row for common master-data endpoints.
    /// Supports Id/Name (registration types, districts) and
    /// CountryId/CountryName or StateId/StateName (geo queries).
    /// </summary>
    public class LookupDto
    {
        public int Id { get; set; }
        public string Name { get; set; } = "";

        public int CountryId { get; set; }
        public string CountryName { get; set; } = "";

        public int StateId { get; set; }
        public string StateName { get; set; } = "";
    }
}
