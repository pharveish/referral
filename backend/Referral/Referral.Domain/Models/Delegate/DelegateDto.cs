namespace Referral.Domain.Models.Delegate
{
    public class DelegateDto
    {
        
        public int Id { get; set; }
        public int DelegateFromId { get; set; } 
        public string DelegateFromName { get; set; } 
        public string DelegateFromSpecialty { get; set; } 
        public string DelegateFromCredentials { get; set; } 
        public int DelegateToId { get; set; } 
        public string DelegateToName { get; set; } 
        public string DelegateToSpecialty { get; set; } 
        public string DelegateToCredentials { get; set; } 
    }
}