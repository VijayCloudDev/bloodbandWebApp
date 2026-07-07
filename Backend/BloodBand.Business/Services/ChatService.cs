using BloodBand.Data;
using BloodBand.Models.DTO;

namespace BloodBand.Business.Services
{
    public class ChatService
    {
        private readonly ChatRepository _repo;

        public ChatService(ChatRepository repo)
        {
            _repo = repo;
        }

        public async Task Send(int senderId, SendMessageDto dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Message))
                throw new Exception("Message cannot be empty");

            await _repo.Send(senderId, dto);
        }

        public async Task<IEnumerable<ChatDto>> Get(int user1, int user2)
        {
            return await _repo.Get(user1, user2);
        }
    }
}
