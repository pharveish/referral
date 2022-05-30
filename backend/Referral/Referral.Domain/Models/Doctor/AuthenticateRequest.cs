using System.ComponentModel.DataAnnotations;

namespace Referral.Domain.Models.Doctor
{
    public class AuthenticateRequest
    {
        [Required] public string Username { get; set; }
        [Required] public string Password { get; set; }
    }
}