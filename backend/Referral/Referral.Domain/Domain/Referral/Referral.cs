using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Referral.Domain.Domain.Referral
{
    public class Referral
    {
        public int Id { get; set; } 
        public DateTime ReferralDate { get; set; } 
        public string Reason { get; set; } 
        public string ClinicalHistory { get; set; } 
        public string Diagnosis { get; set; } 
        public string Notes { get; set; } 
        
        public string Status { get; set; } 
        
        public string RejectionRemark { get; set; } 
        
        public string CompletionMessage { get; set; } 
        
        public DateTime AppointmentDate { get; set; } 
        
        public bool RadiologyExam { get; set; } 
        
        public bool LaboratoryTest { get; set; } 
        
        public bool FollowUp { get; set; } 
        
        
        [ForeignKey("ReferredFrom")]
        public int DoctorFromId { get; set; } 
        public virtual Doctor.Doctor ReferredFrom { get; set; } 
        
        [ForeignKey("Delegate")]
        public int? DelegateId { get; set; }
        public virtual Delegate.Delegate Delegate{ get; set; } 
        
        [ForeignKey("ReferredTo")]
        public int DoctorToId { get; set; } 
        public virtual Doctor.Doctor ReferredTo { get; set; } 
        
        [ForeignKey("Patient")]
        public int PatientId { get; set; } 
        public virtual Patient.Patient Patient { get; set; } 
    }
}