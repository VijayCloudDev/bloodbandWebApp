using Dapper;
using System.Data;
using BloodBand.Models;
using BloodBand.Models.DTO;

namespace BloodBand.Data
{
    public class RequestRepository
    {
        private readonly DapperContext _context;

        public RequestRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task Create(RequestModel model)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_Request_Create",
                model,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<IEnumerable<RequestDto>> GetAll()
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryAsync<RequestDto>(
                "sp_Request_GetAll",
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task<RequestDetailDto?> GetById(int id)
        {
            using var conn = _context.CreateConnection();

            return await conn.QueryFirstOrDefaultAsync<RequestDetailDto>(
                "sp_Request_GetById",
                new { RequestId = id },
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task Update(RequestModel model)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_Request_Update",
                model,
                commandType: CommandType.StoredProcedure
            );
        }

        public async Task Delete(int id)
        {
            using var conn = _context.CreateConnection();

            await conn.ExecuteAsync(
                "sp_Request_Delete",
                new { RequestId = id },
                commandType: CommandType.StoredProcedure
            );
        }
    }
}