using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models
{
    public class UserModel
    {
        public int UserId { get; set; }
        public string? FullName { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Email { get; set; }
        public string? PasswordHash { get; set; }

        public string? Gender { get; set; }

        public int BloodGroupId { get; set; }
        public string? BloodGroupName { get; set; }

        public int RoleId { get; set; }
        public string? RoleName { get; set; }

        public int? CountryId { get; set; }
        public int? StateId { get; set; }
        public int? DistrictId { get; set; }

        public string? Place { get; set; }
        public string? CurrentAddress { get; set; }
        public string? PermanentAddress { get; set; }

        public string? ProfileImageUrl { get; set; }
    }

}

