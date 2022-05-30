using System.ComponentModel.DataAnnotations.Schema;

namespace Referral.Domain.Domain.Delegate
{
    public class Delegate
    {
        public int Id { get; set; }
        public string Notes { get; set; }
        
        
        [ForeignKey("DelegateFrom")]
        public int DelegateFromId { get; set; } 
        public virtual Doctor.Doctor DelegateFrom { get; set; } 
        
        [ForeignKey("DelegateTo")]
        public int DelegateToId { get; set; } 
        public virtual Doctor.Doctor DelegateTo { get; set; } 
    }
}