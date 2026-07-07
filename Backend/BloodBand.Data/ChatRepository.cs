using BloodBand.Models.DTO;
using Dapper;
using System.Data;

namespace BloodBand.Data
{
    public class ChatRepository
    {
        private readonly DapperContext _context;

        public ChatRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task Send(int senderId, SendMessageDto dto)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
    "sp_Chat_Send",
    new { SenderId = senderId, ReceiverId = dto.ReceiverId, Message = dto.Message },
    commandType: CommandType.StoredProcedure
);

        }

        public async Task<IEnumerable<ChatDto>> Get(int user1, int user2)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<ChatDto>(
     "sp_Chat_Get",
     new { User1 = user1, User2 = user2 },
     commandType: CommandType.StoredProcedure
 );
        }
    }
}
