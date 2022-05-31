namespace Referral.Domain.Models.Patient
{
    public class PatientDto
    {
        public int Id { get; set; }
        
        public string Username { get; set; }
        
        public string Password { get; set; }
        public string FbToken { get; set; } 
        
        public string PatientName { get; set; }
        
        public string Nric { get; set; }
        
        public string Gender { get; set; }
        
        public string HomeNo { get; set; }
        
        public string MobileNo { get; set; }
        
        public string Email { get; set; }
        
        public string Address { get; set; }
    }
}