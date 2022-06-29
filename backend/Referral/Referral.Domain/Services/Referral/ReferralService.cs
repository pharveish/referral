using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Mapster;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Referral.Domain.Context;
using Referral.Domain.Domain.Document;
using Referral.Domain.Helpers;
using Referral.Domain.Models.Document;
using Referral.Domain.Models.Referral;

namespace Referral.Domain.Services.Referral
{
    public class ReferralService
    {
        
        public static IWebHostEnvironment _environment;
        private readonly RContext _rContext;
        private readonly AppSettings _appSettings; 
        DateTime currenteDate = DateTime.UtcNow.Date.AddDays(-2);

        public ReferralService(RContext rContext, IOptions<AppSettings> appSettings, IWebHostEnvironment environment)
        {
            _rContext = rContext;
            _appSettings = appSettings.Value;
            _environment = environment;
        }

        public async Task<ReferralDto> AddReferral(ReferralDto input, Domain.Referral.Referral referral = null)
        {
            referral = new Domain.Referral.Referral();
            referral.Diagnosis = input.Diagnosis;
            referral.Notes = input.Notes;
            referral.PatientId = input.PatientId;
            referral.DoctorFromId = input.DoctorFromId;
            referral.DoctorToId = input.DoctorToId;
            referral.Reason = input.Reason;
            referral.ClinicalHistory = input.ClinicalHistory;
            referral.ReferralDate = input.ReferralDate;
            referral.Status = "Pending";
            referral.RadiologyExam = input.RadiologyExam;
            referral.LaboratoryTest = input.LaboratoryTest;
            referral.FollowUp = input.FollowUp;
            _rContext.Referrals.Add(referral);
            await _rContext.SaveChangesAsync();
            return referral.Adapt<ReferralDto>();
        }

        public async Task<ReferralDto> RejectReferral(int id, ReferralDto input)
        {
            Domain.Referral.Referral referral = await _rContext.Referrals.FirstOrDefaultAsync(x => x.Id == id);
            referral.RejectionRemark = input.RejectionRemark;
            referral.Status = "Rejected";
            _rContext.Referrals.Update(referral);
            await _rContext.SaveChangesAsync();
            return referral.Adapt<ReferralDto>();
        }
        
        public async Task<Domain.Referral.Referral> DenyAppointment(int id)
        {
            Domain.Referral.Referral referral = await _rContext.Referrals.FirstOrDefaultAsync(x => x.Id == id);
            referral.Status = "Appointment Denied";
            _rContext.Referrals.Update(referral);
            await _rContext.SaveChangesAsync();
            
            return referral;
        }
        
        public async Task<ReferralDto> CompleteCase(int id, ReferralDto input)
        {
            Domain.Referral.Referral referral = await _rContext.Referrals.FirstOrDefaultAsync(x => x.Id == id);
            referral.CompletionMessage = input.CompletionMessage;
            referral.Status = "Completed";
            _rContext.Referrals.Update(referral);
            await _rContext.SaveChangesAsync();
            return referral.Adapt<ReferralDto>();
            //return referral.Adapt<ReferralDto>();
        }
        
        public async Task<ReferralDto> AbortCase(int id)
        {
            Domain.Referral.Referral referral = await _rContext.Referrals.FirstOrDefaultAsync(x => x.Id == id);
            referral.Status = "Aborted";
            _rContext.Referrals.Update(referral);
            await _rContext.SaveChangesAsync();
            return referral.Adapt<ReferralDto>();
        }
        
        // public async Task<ReferralDto> Delegate(int id, ReferralDto input)
        // {
        //     Domain.Referral.Referral referral = await _rContext.Referrals.FirstOrDefaultAsync(x => x.Id == id);
        //     referral.Delegate.Id = input.DelegateId;
        //     //referral.ReferredTo.Name = input.DoctorToName;
        //     referral.Status = "Pending";
        //     _rContext.Referrals.Update(referral);
        //     await _rContext.SaveChangesAsync();
        //     return referral.Adapt<ReferralDto>();
        // }
        
        public async Task<ReferralDto> Reassign(int id, ReferralDto input)
        {
            Domain.Referral.Referral referral = await _rContext.Referrals.FirstOrDefaultAsync(x => x.Id == id);
            referral.DoctorToId = input.DoctorToId;
            //referral.ReferredTo.Name = input.DoctorToName;
            referral.Status = "Pending";
            _rContext.Referrals.Update(referral);
            await _rContext.SaveChangesAsync();
            return referral.Adapt<ReferralDto>();
        }
        
        public async Task<ReferralDto> SetAppointment(int id, ReferralDto input)
        {
            Domain.Referral.Referral referral = await _rContext.Referrals.FirstOrDefaultAsync(x => x.Id == id);
            referral.AppointmentDate = input.AppointmentDate;
            referral.Status = "Confirmed";
            _rContext.Referrals.Update(referral);
            await _rContext.SaveChangesAsync();
            return referral.Adapt<ReferralDto>();
        }

        public async Task<Domain.Referral.Referral> GetReferralObjectById(int id)
        {
            return await _rContext.Referrals.AsQueryable()
                .Where(x => x.Id == id)
                .SingleOrDefaultAsync();
        }
        public async Task<ReferralDto> GetReferralById(int id)
        {
            return await _rContext.Referrals.AsQueryable()
                .Select(x =>
                    new
                    {
                        x.Id,
                        x.Diagnosis,
                        x.Notes,
                        x.Reason,
                        x.ClinicalHistory,
                        PatientId = x.Patient.Id,
                        x.DoctorFromId,
                        DoctorFromName = x.ReferredFrom.Name,
                        x.DoctorToId,
                        DoctorToName = x.ReferredTo.Name,
                        PatientName = x.Patient.PatientName,
                        ReferToHospital= x.ReferredFrom.Hospital,
                         // x.DelegateId,
                         // DelegateToId = x.Delegate.DelegateTo.Id,
                         // DelegateToName = x.Delegate.DelegateTo.Name,
                         // DelegateFromId = x.Delegate.DelegateFrom.Id,
                         // DelegateFromName = x.Delegate.DelegateFrom.Name,
                        PatientIc = x.Patient.Nric,
                        PatientGender = x.Patient.Gender,
                        PatientHomeNo = x.Patient.HomeNo,
                        PatientMobileNo = x.Patient.MobileNo,
                        PatientEmail = x.Patient.Email,
                        PatientAddress = x.Patient.Address,
                        Status = x.Status,
                        RejectionRemark = x.RejectionRemark,
                        AppointmentDate = x.AppointmentDate,
                        x.CompletionMessage,
                        x.RadiologyExam,
                        x.LaboratoryTest,
                        x.FollowUp,
                    })
                .Where(x => x.Id == id)
                .ProjectToType<ReferralDto>()
                .SingleOrDefaultAsync();
        }
        public async Task<List<ReferralDto>> GetReferredToByDoctorId(int id)
        {

            return await _rContext.Referrals.AsQueryable()
                .Select(x =>
                    new
                    {
                        x.Id,
                        x.Diagnosis,
                        x.Notes,
                        x.Reason,
                        x.ClinicalHistory,
                        PatientId = x.Patient.Id,
                        // x.DelegateId,
                        // DelegateToId = x.Delegate.DelegateTo.Id,
                        // DelegateToName = x.Delegate.DelegateTo.Name,
                        // DelegateFromId = x.Delegate.DelegateFrom.Id,
                        // DelegateFromName = x.Delegate.DelegateFrom.Name,
                        x.DoctorFromId,
                        DoctorFromName = x.ReferredFrom.Name,
                        x.DoctorToId,
                        DoctorToName = x.ReferredTo.Name,
                        PatientName = x.Patient.PatientName,
                        ReferToHospital= x.ReferredFrom.Hospital,
                        PatientIc = x.Patient.Nric,
                        PatientGender = x.Patient.Gender,
                        PatientHomeNo = x.Patient.HomeNo,
                        PatientMobileNo = x.Patient.MobileNo,
                        PatientEmail = x.Patient.Email,
                        PatientAddress = x.Patient.Address,
                        Status = x.Status,
                        RejectionRemark = x.RejectionRemark,
                        AppointmentDate = x.AppointmentDate,
                        x.CompletionMessage,
                        x.RadiologyExam,
                        x.LaboratoryTest,
                        x.FollowUp,
                    })
                .Where(x => x.DoctorToId == id )
                .ProjectToType<ReferralDto>()
                .ToListAsync();
        }

        public async Task<List<DateTime>> GetReferredToDatesByDoctorId(int id)
        {
            return await _rContext.Referrals.AsQueryable().Where(x=>x.DoctorToId==id && x.ReferralDate >= currenteDate).Select(x => x.ReferralDate.Date).Distinct().ToListAsync();
        }
        public async Task<List<DateTime>> GetReferredToDatesHistoryByDoctorId(int id)
        {
            return await _rContext.Referrals.AsQueryable().Where(x=>x.DoctorToId==id || x.DoctorFromId == id).Select(x => x.ReferralDate.Date).Distinct().ToListAsync();
        }
        
        public async Task<List<DateTime>> GetReferredToDatesByPatientId(int id)
        {
            return await _rContext.Referrals.AsQueryable().Where(x=>x.PatientId==id).Select(x => x.ReferralDate.Date).Distinct().ToListAsync();
        }
        
        public async Task<List<DateTime>> GetReferredToDatesByPatientIdAndStatus(int id, string status)
        {
            return await _rContext.Referrals.AsQueryable().Where(x=>x.PatientId==id && x.Status==status).Select(x => x.ReferralDate.Date).Distinct().ToListAsync();
        }
        
        public async Task<List<DateTime>> GetReferredToDatesByDoctorFromId(int id)
        {
            return await _rContext.Referrals.AsQueryable().Where(x=>x.DoctorFromId==id && x.ReferralDate >= currenteDate).Select(x => x.ReferralDate.Date).Distinct().ToListAsync();
        }

        public async Task<List<ReferralDto>> GetDoctorFromReferralsByDate(int id, DateTime date)
        {
            return await _rContext.Referrals.AsQueryable()
                .Select(x =>
                    new
                    {
                        x.Id,
                        x.Reason,
                        x.DoctorToId,
                        x.DoctorFromId,
                        referToHospital=x.ReferredFrom.Hospital,
                        x.ReferralDate,
                        x.Patient.PatientName,
                        PatientIc=x.Patient.Nric,
                        //x.DelegateId,
                        // DelegateToId = x.Delegate.DelegateTo.Id,
                        // DelegateToName = x.Delegate.DelegateTo.Name,
                        // DelegateFromId = x.Delegate.DelegateFrom.Id,
                        // DelegateFromName = x.Delegate.DelegateFrom.Name,
                        DoctorToName = x.ReferredTo.Name,
                        Status = x.Status,
                        RejectionRemark = x.RejectionRemark,
                        AppointmentDate = x.AppointmentDate,
                        x.CompletionMessage,
                        x.RadiologyExam,
                        x.LaboratoryTest,
                        x.FollowUp,

                    })
                .Where(x => x.DoctorFromId==id && x.ReferralDate.Date == date.Date)
                .ProjectToType<ReferralDto>()
                .ToListAsync();
        }
        
        public async Task<List<ReferralDto>> GetReferralHistoryByDate(int id, DateTime date)
        {
            return await _rContext.Referrals.AsQueryable()
                .Select(x =>
                    new
                    {
                        x.Id,
                        x.Reason,
                        x.DoctorToId,
                        x.DoctorFromId,
                        referToHospital=x.ReferredFrom.Hospital,
                        x.ReferralDate,
                        x.Patient.PatientName,
                        PatientIc=x.Patient.Nric,
                        //x.DelegateId,
                        // DelegateToId = x.Delegate.DelegateTo.Id,
                        // DelegateToName = x.Delegate.DelegateTo.Name,
                        // DelegateFromId = x.Delegate.DelegateFrom.Id,
                        // DelegateFromName = x.Delegate.DelegateFrom.Name,
                        DoctorToName = x.ReferredTo.Name,
                        Status = x.Status,
                        RejectionRemark = x.RejectionRemark,
                        AppointmentDate = x.AppointmentDate,
                        x.CompletionMessage,
                        x.RadiologyExam,
                        x.LaboratoryTest,
                        x.FollowUp,

                    })
                .Where(x => x.DoctorFromId==id || x.DoctorToId ==id && x.ReferralDate.Date == date.Date)
                .ProjectToType<ReferralDto>()
                .ToListAsync();
        }
        
        public async Task<List<ReferralDto>> GetReferralsByDateByPatientIdAndStatus(int id, DateTime date, string status)
        {
            return await _rContext.Referrals.AsQueryable()
                .Select(x =>
                    new
                    {
                        x.Id,
                        x.Reason,
                        x.DoctorToId,
                        x.DoctorFromId,
                        referToHospital=x.ReferredFrom.Hospital,
                        x.ReferralDate,
                        // x.DelegateId,
                        // DelegateToId = x.Delegate.DelegateTo.Id,
                        // DelegateToName = x.Delegate.DelegateTo.Name,
                        // DelegateFromId = x.Delegate.DelegateFrom.Id,
                        // DelegateFromName = x.Delegate.DelegateFrom.Name,
                        x.PatientId,
                        x.Patient.PatientName,
                        PatientIc=x.Patient.Nric,
                        DoctorToName = x.ReferredTo.Name,
                        Status = x.Status,
                        RejectionRemark = x.RejectionRemark,
                        AppointmentDate = x.AppointmentDate,
                        x.CompletionMessage,
                        x.RadiologyExam,
                        x.LaboratoryTest,
                        x.FollowUp,

                    })
                .Where(x => x.PatientId==id && x.ReferralDate.Date == date.Date && x.Status==status)
                .ProjectToType<ReferralDto>()
                .ToListAsync();
        }
        
        public async Task<List<ReferralDto>> GetReferralsByDateByPatientId(int id, DateTime date)
        {
            return await _rContext.Referrals.AsQueryable()
                .Select(x =>
                    new
                    {
                        x.Id,
                        x.Reason,
                        x.DoctorToId,
                        x.DoctorFromId,
                        referToHospital=x.ReferredFrom.Hospital,
                        DoctorToName = x.ReferredTo.Name,
                        // x.DelegateId,
                        // DelegateToId = x.Delegate.DelegateTo.Id,
                        // DelegateToName = x.Delegate.DelegateTo.Name,
                        // DelegateFromId = x.Delegate.DelegateFrom.Id,
                        // DelegateFromName = x.Delegate.DelegateFrom.Name,
                        x.ReferralDate,
                        x.PatientId,
                        x.Patient.PatientName,
                        PatientIc=x.Patient.Nric,
                        Status = x.Status,
                        RejectionRemark = x.RejectionRemark,
                        AppointmentDate = x.AppointmentDate,
                        x.CompletionMessage,
                        x.RadiologyExam,
                        x.LaboratoryTest,
                        x.FollowUp,

                    })
                .Where(x => x.PatientId==id && x.ReferralDate.Date == date.Date)
                .ProjectToType<ReferralDto>()
                .ToListAsync();
        }
        
        public async Task<List<ReferralDto>> GetReferralsByDate(int id, DateTime date)
        {
            return await _rContext.Referrals.AsQueryable()
                .Select(x =>
                    new
                    {
                        x.Id,
                        x.Reason,
                        x.DoctorToId,
                        x.ReferralDate,
                        x.Patient.PatientName,
                        PatientIc=x.Patient.Nric,
                        DoctorToName = x.ReferredTo.Name,
                        // x.DelegateId,
                        // DelegateToId = x.Delegate.DelegateTo.Id,
                        // DelegateToName = x.Delegate.DelegateTo.Name,
                        // DelegateFromId = x.Delegate.DelegateFrom.Id,
                        // DelegateFromName = x.Delegate.DelegateFrom.Name,
                        Status = x.Status,
                        RejectionRemark = x.RejectionRemark,
                        AppointmentDate = x.AppointmentDate,
                        x.CompletionMessage,
                        x.RadiologyExam,
                        x.LaboratoryTest,
                        x.FollowUp,

                    })
                .Where(x => x.DoctorToId==id && x.ReferralDate.Date == date.Date)
                .ProjectToType<ReferralDto>()
                .ToListAsync();
        }
        public class FileUploadAPI
        {
            public IFormFile files { get; set; }
        }

        public async Task<List<CompletedDocumentDto>> GetCompletedDocumentsByReferralId(int referralId)
        {
            return await _rContext.CompletedDocuments.AsQueryable().Where(x => x.ReferralId == referralId)
                .ProjectToType<CompletedDocumentDto>().ToListAsync();
        }
        
        public async Task<List<DocumentDto>> GetDocumentsByReferralId(int referralId)
        {
            return await _rContext.Documents.AsQueryable().Where(x => x.ReferralId == referralId)
                .ProjectToType<DocumentDto>().ToListAsync();
        }

        public async Task<string> UploadCompletedFile(FileUploadAPI objFile, string fileName, int referralId, CompletedDocument document=null)
        {
            
            try
            {
                if (objFile.files.Length > 0)
                {
                    if (!Directory.Exists(_environment.WebRootPath + $"/Upload/Completed/{referralId}/"))
                    {
                        Directory.CreateDirectory(_environment.WebRootPath + $"/Upload/Completed/{referralId}/");
                    }

                    Guid id = Guid.NewGuid();
                    using (FileStream fileStream =
                        System.IO.File.Create(_environment.WebRootPath + $"/Upload/Completed/{referralId}/" + id))
                        //System.IO.File.Create(_environment.WebRootPath + "/Upload/" + objFile.files.FileName))
                    {
                        document = new CompletedDocument();
                        document.Id = id;
                        document.FileName = fileName+System.IO.Path.GetExtension(objFile.files.FileName);
                        document.ContentType = objFile.files.ContentType;
                        document.FileSize = objFile.files.Length;
                        document.ReferralId = referralId;
                        objFile.files.CopyTo(fileStream);
                        fileStream.Flush();
                        _rContext.CompletedDocuments.Add(document);
                        await _rContext.SaveChangesAsync();
                        return "/Upload/Completed/" + objFile.files.FileName;
                    }
                }
                else
                {
                    return "Failed";
                }
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }
        public async Task<string> UploadFile(FileUploadAPI objFile, string fileName, int referralId, Document document=null)
        {
            
            try
            {
                if (objFile.files.Length > 0)
                {
                    if (!Directory.Exists(_environment.WebRootPath + $"/Upload/{referralId}/"))
                    {
                        Directory.CreateDirectory(_environment.WebRootPath + $"/Upload/{referralId}/");
                    }

                    Guid id = Guid.NewGuid();
                    using (FileStream fileStream =
                        System.IO.File.Create(_environment.WebRootPath + $"/Upload/{referralId}/" + id))
                        //System.IO.File.Create(_environment.WebRootPath + $"/Upload/{referralId}/" + fileName+System.IO.Path.GetExtension(objFile.files.FileName)))
                        //System.IO.File.Create(_environment.WebRootPath + "/Upload/" + objFile.files.FileName))
                    {
                        document = new Document();
                        document.Id = id;
                        document.FileName = fileName+System.IO.Path.GetExtension(objFile.files.FileName);
                        document.ContentType = objFile.files.ContentType;
                        document.FileSize = objFile.files.Length;
                        document.ReferralId = referralId;
                        objFile.files.CopyTo(fileStream);
                        fileStream.Flush();
                        _rContext.Documents.Add(document);
                        await _rContext.SaveChangesAsync();
                        return "/Upload/" + objFile.files.FileName;
                    }
                }
                else
                {
                    return "Failed";
                }
            }
            catch (Exception ex)
            {
                return ex.Message.ToString();
            }
        }

        public async Task<CompletedDocument> getCompletedDocumentToDownload(Guid id)
        {
            var document = await _rContext.CompletedDocuments.FindAsync(id);
            return document;
        }
        
        public async Task<Document> getDocumentToDownload(Guid id)
        {
            var document = await _rContext.Documents.FindAsync(id);
            return document;
        }

    }
}