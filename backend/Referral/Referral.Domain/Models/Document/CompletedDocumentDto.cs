namespace Referral.Domain.Models.Document
{
    public class CompletedDocumentDto
    {
        
        public int Id { get; set; } 
        
        public string FileName { get; set; } 
        
        public string ContentType { get; set; } 
        
        public string FileSize { get; set; } 
        
        public int ReferralId { get; set; } 
    }
}