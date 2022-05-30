namespace Referral.Domain.Domain.Doctor
{
    public class Doctor
    {
        public int Id { get; set; }
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string FbToken { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Credentials { get; set; } = string.Empty;
        public string Specialty { get; set; } = string.Empty;
        
        public string Hospital { get; set; } = string.Empty;

        public string OfficePhone { get; set; } = string.Empty;

        public string MobilePhone { get; set; } = string.Empty;

        public string Fax { get; set; } = string.Empty;

        public string PracticeLocation { get; set; } = string.Empty;
    }
}