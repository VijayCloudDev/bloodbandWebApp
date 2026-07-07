using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models.DTO
{
    public class ChangePasswordDto
    {
        public string OldPasswordHash { get; set; } = "";
        public string NewPasswordHash { get; set; } = "";
    }
}
