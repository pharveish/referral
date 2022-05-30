using System;

namespace Referral.Domain.Models.Referral
{
    public class ReferralDto
    {
        public int Id { get; set; } 
        public DateTime ReferralDate { get; set; } 
        public string Reason { get; set; } 
        public string ClinicalHistory { get; set; } 
        public string Diagnosis { get; set; } 
        public string Notes { get; set; } 
        public int DoctorFromId { get; set; } 
        public string DoctorFromName { get; set; } 
        public int DoctorToId { get; set; } 
        public string DoctorToName { get; set; } 
        
        // public int DelegateId { get; set; } 
        // public string DelegateToName { get; set; } 
        // public int DelegateFromName { get; set; } 
        public int PatientId { get; set; } 
        public string ReferToHospital { get; set; } 
        public string PatientName { get; set; } 
        public string PatientIc { get; set; } 
        public string PatientGender { get; set; } 
        public string PatientHomeNo { get; set; } 
        public string PatientMobileNo { get; set; } 
        public string PatientEmail { get; set; } 
        public string PatientAddress { get; set; } 
        public string Status { get; set; } 
        public bool RadiologyExam { get; set; } 
        public bool LaboratoryTest { get; set; } 
        public bool FollowUp { get; set; } 
        public string RejectionRemark { get; set; } 
        public string CompletionMessage { get; set; } 
        public DateTime AppointmentDate { get; set; } 
    }
}