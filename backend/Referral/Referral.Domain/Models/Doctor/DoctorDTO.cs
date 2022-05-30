namespace Referral.Domain.Models.Doctor
{
    public class DoctorDTO
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string FbToken { get; set; } 
        public string Email { get; set; }
        public string Name { get; set; }
        public string Credentials { get; set; }
        public string Specialty { get; set; }
        public string Hospital { get; set; }
        
        public string OfficePhone { get; set; }
        
        public string MobilePhone { get; set; }
        
        public string Fax { get; set; }
        
        public string PracticeLocation { get; set; }
    }
}