namespace Referral.Domain.Models.Patient
{
    public class AuthenticateResponsePatient
    {
        public int Id { get; set; }
        
        public string Username { get; set; }
        
        public string Password { get; set; }
        
        public string PatientName { get; set; }
        
        public string Nric { get; set; }
        
        public string Gender { get; set; }
        
        public string HomeNo { get; set; }
        
        public string MobileNo { get; set; }
        
        public string Email { get; set; }
        
        public string Address { get; set; }
        
        public string Token { get; set; }

        public AuthenticateResponsePatient(PatientDto patient, string token)
        {
            Id = patient.Id;
            Username = patient.Username;
            Password = patient.Password;
            Email = patient.Email;
            PatientName = patient.PatientName;
            Nric = patient.Nric;
            Address = patient.Address;
            Gender = patient.Gender;
            HomeNo = patient.HomeNo;
            MobileNo = patient.MobileNo;
            Token = token;
        }
    }
}
