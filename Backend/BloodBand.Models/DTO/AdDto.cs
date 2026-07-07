using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models.DTO
{
    public class AdDto
    {
        public int AdId { get; set; }
        public string Title { get; set; } = "";
        public string ImageUrl { get; set; } = "";
        public string RedirectUrl { get; set; } = "";
    }

}
