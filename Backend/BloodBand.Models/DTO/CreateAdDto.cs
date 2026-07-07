using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models.DTO
{
    public class CreateAdDto
    {
        public string Title { get; set; } = "";
        public string ImageUrl { get; set; } = "";
        public string RedirectUrl { get; set; } = "";
    }
}
