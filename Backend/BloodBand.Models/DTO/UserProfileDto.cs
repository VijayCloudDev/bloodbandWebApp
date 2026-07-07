using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models.DTO
{
    public class UserProfileDto
    {
        public int UserId { get; set; }
        public string FullName { get; set; } = "";
        public string PhoneNumber { get; set; } = "";
        public string Email { get; set; } = "";
        public string Gender { get; set; } = "";

        public string BloodGroupName { get; set; } = "";
        public string ProfileImageUrl { get; set; } = "";

        public string CountryName { get; set; } = "";
        public string StateName { get; set; } = "";
        public string DistrictName { get; set; } = "";

        public string Place { get; set; } = "";
        public string CurrentAddress { get; set; } = "";
        public string PermanentAddress { get; set; } = "";
    }
}
