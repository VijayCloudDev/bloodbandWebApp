using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models.DTO
{
    public class RequestDetailDto
    {
        public int RequestId { get; set; }
        public string PatientName { get; set; } = "";
        public string BloodGroupName { get; set; } = "";
        public int UnitsNeeded { get; set; }
        public string District { get; set; } = "";
        public DateTime RequestDate { get; set; }
    }
}
