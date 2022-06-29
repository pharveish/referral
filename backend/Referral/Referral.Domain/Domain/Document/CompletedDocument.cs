using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Referral.Domain.Domain.Document
{
    public class CompletedDocument
    {
        public Guid Id { get; set; } 
        
        public string FileName { get; set; } 
        
        public string ContentType { get; set; } 
        
        public long FileSize { get; set; } 
        
        [ForeignKey("Referral")]
        public int ReferralId { get; set; } 
        public virtual Referral.Referral Referral { get; set; } 
    }
}