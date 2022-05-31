using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using FirebaseAdmin.Messaging;
using Mapster;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using Referral.Domain.Models.Document;
using Referral.Domain.Models.Referral;
using Referral.Domain.Services.Referral;

namespace Referral.Controllers.Referral
{
    [Route("api/[controller]")]
    public class ReferralController : ControllerBase
    {
        private readonly ReferralService _referralService;
        public static IWebHostEnvironment _environment;

        public ReferralController(ReferralService referralService, IWebHostEnvironment environment)
        {
            _referralService = referralService;
            _environment = environment;
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] ReferralDto input)
        {
            ReferralDto referral = await _referralService.AddReferral(input);
            return Ok(referral);
        }

        [HttpPut("reject/{id}")]
        public async Task<IActionResult> RejectReferral(int id, [FromBody] ReferralDto input)
        {
            ReferralDto referralDto = await _referralService.RejectReferral(id, input);
            Domain.Domain.Referral.Referral referral = await _referralService.GetReferralObjectById(id);
            var message = new Message()
            {
            Notification = new Notification
            {
                Title = "Appointment Rejected",
                Body = "Your referral to "+referral.ReferredTo.Name+" on "+referral.ReferralDate+" has been rejected."
            },
            Token = referral.ReferredFrom.FbToken
            };
            var messaging = FirebaseMessaging.DefaultInstance;
            var result = await messaging.SendAsync(message);
            return Ok(referralDto);
        }
        
        [HttpPut("denyAppointment/{id}")]
        public async Task<IActionResult> DenyAppointment(int id )
        {
            Domain.Domain.Referral.Referral referral = await _referralService.DenyAppointment(id );
            var message = new Message()
            {
            Notification = new Notification
            {
                Title = "Appointment Denied",
                Body = "Your appointment on "+referral.AppointmentDate+" had been denied."
            },
            Token = referral.ReferredTo.FbToken
            };
            var messaging = FirebaseMessaging.DefaultInstance;
            var result = await messaging.SendAsync(message);
            return Ok(referral);
        }
        
        [HttpPut("completeCase/{id}")]
        public async Task<IActionResult> CompleteCase(int id, [FromBody] ReferralDto input)
        {
            ReferralDto referralDto = await _referralService.CompleteCase(id, input);
            Domain.Domain.Referral.Referral referral = await _referralService.GetReferralObjectById(id);
            var message = new Message()
            {
            Notification = new Notification
            {
                Title = "Case Complete",
                Body = "Your referral to "+referral.ReferredTo.Name+" on "+referral.ReferralDate+" has been completed."
            },
            Token = referral.ReferredFrom.FbToken
            };
            var messaging = FirebaseMessaging.DefaultInstance;
            var result = await messaging.SendAsync(message);
            return Ok(referralDto);
        }
        
        // [HttpPut("delegate/{id}")]
        // public async Task<IActionResult> Delegate(int id, [FromBody] ReferralDto input)
        // {
        //     ReferralDto referral = await _referralService.Delegate(id, input);
        //     return Ok(referral);
        // }
        
        [HttpPut("reassign/{id}")]
        public async Task<IActionResult> Reassign(int id, [FromBody] ReferralDto input)
        {
            ReferralDto referralDto = await _referralService.Reassign(id, input);
            Domain.Domain.Referral.Referral referral = await _referralService.GetReferralObjectById(id);
            var message = new Message()
            {
            Notification = new Notification
            {
                Title = "A referral has been reassigned to you",
                Body = "A referral from "+referral.ReferredFrom.Name+" on "+referral.ReferralDate+" has been reassigned to you."
            },
            Token = referral.ReferredTo.FbToken
            };
            var messaging = FirebaseMessaging.DefaultInstance;
            var result = await messaging.SendAsync(message);
            return Ok(referralDto);
        }
        
        [HttpPut("abort/{id}")]
        public async Task<IActionResult> AbortCase(int id)
        {
            ReferralDto referral = await _referralService.AbortCase(id);
            return Ok(referral);
        }
        
        [HttpPut("setAppointment/{id}")]
        public async Task<IActionResult> SetAppointment(int id, [FromBody] ReferralDto input)
        {
            ReferralDto referralDto = await _referralService.SetAppointment(id, input);
            Domain.Domain.Referral.Referral referral = await _referralService.GetReferralObjectById(id);
            var message = new Message()
            {
            Notification = new Notification
            {
                Title = "Referral Accepted",
                Body = "Your referral to "+referral.ReferredTo.Name+" on "+referral.ReferralDate+" has been accepted. The appointment date is on "+referral.AppointmentDate+" ."
            },
            Token = referral.ReferredFrom.FbToken
            };
            var messaging = FirebaseMessaging.DefaultInstance;
            var result = await messaging.SendAsync(message);
            return Ok(referralDto);
        }

        [HttpGet("referredToId/{id}")]
        public async Task<List<ReferralDto>> GetReferralByReferredToId(int id)
        {
            List<ReferralDto> referrals = await _referralService.GetReferredToByDoctorId(id);
            return referrals;
        }
        
        [HttpGet("referralById/{id}")]
        public async Task<ReferralDto> GetReferralById(int id)
        {
            ReferralDto referral = await _referralService.GetReferralById(id);
            return referral;
        }
        
        [HttpGet("datesOfReferredTo/{id}")]
        public async Task<List<DateTime>> GetDates (int id)
        {
            List<DateTime> dates = await _referralService.GetReferredToDatesByDoctorId(id);
            return dates;
        }
        
        [HttpGet("datesOfPatients/{id}")]
        public async Task<List<DateTime>> GetPatientDates (int id)
        {
            List<DateTime> dates = await _referralService.GetReferredToDatesByPatientId(id);
            return dates;
        }
        
        [HttpGet("datesOfPatients/{id}/{status}")]
        public async Task<List<DateTime>> GetPatientDatesByStatus (int id, string status)
        {
            List<DateTime> dates = await _referralService.GetReferredToDatesByPatientIdAndStatus(id,status);
            return dates;
        }
        
        [HttpGet("datesOfReferredReferredFrom/{id}")]
        public async Task<List<DateTime>> GetDatesDoctorFrom (int id)
        {
            List<DateTime> dates = await _referralService.GetReferredToDatesByDoctorFromId(id);
            return dates;
        }
        
        [HttpGet("referralByDate/{id}/{date}")]
        public async Task<List<ReferralDto>> GetReferralsByDate (int id, DateTime date)
        {
            List<ReferralDto> referrals = await _referralService.GetReferralsByDate(id,date);
            return referrals;
        }
        
        [HttpGet("referralByDateDoctorFrom/{id}/{date}")]
        public async Task<List<ReferralDto>> GetReferralsByDateDoctorFrom (int id, DateTime date)
        {
            List<ReferralDto> referrals = await _referralService.GetDoctorFromReferralsByDate(id,date);
            return referrals;
        }
        
        [HttpGet("referralByDatePatient/{id}/{date}")]
        public async Task<List<ReferralDto>> GetReferralsByDatePatient (int id, DateTime date)
        {
            List<ReferralDto> referrals = await _referralService.GetReferralsByDateByPatientId(id,date);
            return referrals;
        }
        
        [HttpGet("referralByDatePatientStatus/{id}/{date}/{status}")]
        public async Task<List<ReferralDto>> GetReferralsByDatePatientStatus (int id, DateTime date, string status)
        {
            List<ReferralDto> referrals = await _referralService.GetReferralsByDateByPatientIdAndStatus(id,date,status);
            return referrals;
        }

        [HttpGet("completedUploadsByReferralId/{id}")]
        public async Task<List<CompletedDocumentDto>> GetCompletedDocumentsByReferralId(int id)
        {
            return await _referralService.GetCompletedDocumentsByReferralId(id);
        }
        
        [HttpGet("uploadsByReferralId/{id}")]
        public async Task<List<DocumentDto>> GetDocumentsByReferralId(int id)
        {
            return await _referralService.GetDocumentsByReferralId(id);
        }
        
        [HttpPost("upload/completed/{id}/{fileName}")]
        public async Task<string> UploadCompletedFile(ReferralService.FileUploadAPI objFile, string fileName, int id)
        {
            return await _referralService.UploadCompletedFile(objFile, fileName, id);
        }
        
        [HttpPost("upload/{id}/{fileName}")]
        public async Task<string> UploadFile(ReferralService.FileUploadAPI objFile, string fileName, int id)
        {
            return await _referralService.UploadFile(objFile, fileName, id);
        }
        
        
        [HttpGet("download/completed/{id}/{referralId}")]
        public async Task<ActionResult> DownloadCompleted(int id, int referralId)
        {
            var provider = new FileExtensionContentTypeProvider();
            var document = await _referralService.getCompletedDocumentToDownload(id);

            if (document == null)
                return new NotFoundResult();

            var file = Path.Combine(_environment.WebRootPath + $"/Upload/Completed/{referralId}/" + document.FileName);
            Console.WriteLine(file);

            string contentType;
            if (!provider.TryGetContentType(file, out contentType))
            {
                contentType = "application/octet-stream";
                Console.WriteLine("Something wrong here");
                
            }

            byte[] fileBytes;
            if (System.IO.File.Exists(file))
            {
                Console.WriteLine("Reading bytes...");
                fileBytes = await System.IO.File.ReadAllBytesAsync(file);
            }
            else
            {
                Console.WriteLine("Read failed");
                return new NotFoundResult();
            }

            return File(fileBytes, contentType, document.FileName);
        }
        
        [HttpGet("download/{id}/{referralId}")]
        public async Task<ActionResult> Download(Guid id, int referralId)
        {
            var provider = new FileExtensionContentTypeProvider();
            var document = await _referralService.getDocumentToDownload(id);

            if (document == null)
                return new NotFoundResult();

            var file = Path.Combine(_environment.WebRootPath + $"/Upload/{referralId}/" + document.Id);
            Console.WriteLine(file);

            string contentType;
            if (!provider.TryGetContentType(file, out contentType))
            {
                contentType = "application/octet-stream";
                Console.WriteLine("Something wrong here");
                
            }

            byte[] fileBytes;
            if (System.IO.File.Exists(file))
            {
                Console.WriteLine("Reading bytes...");
                fileBytes = await System.IO.File.ReadAllBytesAsync(file);
            }
            else
            {
                Console.WriteLine("Read failed");
                return new NotFoundResult();
            }

            return File(fileBytes, contentType, document.FileName);
        }
    }
}
