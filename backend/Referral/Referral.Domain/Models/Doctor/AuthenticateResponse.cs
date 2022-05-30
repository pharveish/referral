namespace Referral.Domain.Models.Doctor
{
    public class AuthenticateResponse
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
        public string Token { get; set; }

        public AuthenticateResponse(DoctorDTO doctor, string token)
        {
            Id = doctor.Id;
            Username = doctor.Username;
            Password = doctor.Password;
            FbToken = doctor.FbToken;
            Email = doctor.Email;
            Name = doctor.Name;
            Credentials = doctor.Credentials;
            Specialty = doctor.Specialty;
            Hospital = doctor.Hospital;
            OfficePhone = doctor.OfficePhone;
            MobilePhone = doctor.MobilePhone;
            Fax = doctor.Fax;
            PracticeLocation = doctor.PracticeLocation;
            Token = token;
        }
    }
}
