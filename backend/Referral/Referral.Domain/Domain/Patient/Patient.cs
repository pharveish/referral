namespace Referral.Domain.Domain.Patient
{
    public class Patient
    {
        public int Id { get; set; }
        
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string PatientName { get; set; }
        
        public string Nric { get; set; }
        
        public string Gender { get; set; }
        
        public string HomeNo { get; set; }
        
        public string MobileNo { get; set; }
        
        public string Email { get; set; }
        
        public string Address { get; set; }
        
    }
}