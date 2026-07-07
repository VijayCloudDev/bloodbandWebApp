using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BloodBand.Models.DTO
{
    public class SendMessageDto
    {
        public int ReceiverId { get; set; }
        public string Message { get; set; } = "";
    }
}
