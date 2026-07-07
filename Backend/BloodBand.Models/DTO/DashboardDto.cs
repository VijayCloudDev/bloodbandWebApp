using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models.DTO
{
    public class DashboardDto
    {
        public DashboardSummaryDto Summary { get; set; } = new();
        public List<RequestDto> RecentRequests { get; set; } = new();
        public List<NotificationDto> Notifications { get; set; } = new();
    }

}
