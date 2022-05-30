using System.ComponentModel.DataAnnotations;

namespace Referral.Domain.Models.Patient
{
    public class AuthenticateRequestPatient
    {
        [Required] public string Username { get; set; }
        [Required] public string Password { get; set; }
    }
}