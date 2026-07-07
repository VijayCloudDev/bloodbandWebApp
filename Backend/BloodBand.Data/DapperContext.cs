using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace BloodBand.Data
{

    public class DapperContext
    {
        private readonly IConfiguration _config;
        private readonly string _connectionString;

        public DapperContext(IConfiguration config)
        {
            _config = config;

            _connectionString = config.GetConnectionString("DefaultConnection")
                            ?? throw new Exception("Connection string 'DefaultConnection' not found.");

        }

        public IDbConnection CreateConnection()
            => new SqlConnection(_connectionString);
    }

}
