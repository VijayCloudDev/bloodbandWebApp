using BloodBand.Data;
using BloodBand.Models.DTO;
using Microsoft.Extensions.Caching.Memory;

namespace BloodBand.Business.Services
{
    public class DashboardService
    {
        private readonly DashboardRepository _repo;
        private readonly IMemoryCache _cache;

        public DashboardService(DashboardRepository repo, IMemoryCache cache)
        {
            _repo = repo;
            _cache = cache;
        }

        public async Task<DashboardDto> GetDashboard(int userId)
        {
            var cacheKey = $"dashboard_{userId}";

            // ✅ 1. Try get from cache


            if (_cache.TryGetValue(cacheKey, out DashboardDto? cachedData) && cachedData != null)
            {
                return cachedData;
            }



            // ✅ 2. Fetch from DB
            var data = await _repo.GetDashboard(userId);

            // ✅ 3. Store in cache
            var cacheOptions = new MemoryCacheEntryOptions()
                .SetAbsoluteExpiration(TimeSpan.FromSeconds(30)); // you can adjust

            _cache.Set(cacheKey, data, cacheOptions);

            return data;
        }
    }
}