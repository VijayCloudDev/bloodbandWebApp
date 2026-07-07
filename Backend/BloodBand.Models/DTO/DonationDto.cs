using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models.DTO
{
    public class DonationDto
    {
        public int DonationId { get; set; }
        public int RequestId { get; set; }
        public DateTime? DonatedDate { get; set; }
        public string StatusName { get; set; } = "";
    }
}
