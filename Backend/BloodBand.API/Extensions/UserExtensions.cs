using System.Security.Claims;

namespace BloodBand.API.Extensions
{
    public static class UserExtensions
    {
        public static int GetUserId(this ClaimsPrincipal user)
        {
            if (user == null)
                throw new ArgumentNullException(nameof(user));

            var claim = user.FindFirst("UserId");

            if (claim == null || string.IsNullOrEmpty(claim.Value))
                throw new UnauthorizedAccessException("UserId claim not found in token");

            return int.Parse(claim.Value);
        }
    }
}