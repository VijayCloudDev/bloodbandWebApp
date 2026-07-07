using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models.DTO
{
    public class DashboardSummaryDto
    {
        public int TotalRequests { get; set; }
        public int MyDonations { get; set; }
        public int PendingRequests { get; set; }
        public int TotalOrganizations { get; set; }
    }

}
