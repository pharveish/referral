using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Referral.Domain.Models.Patient;
using Referral.Domain.Services.Patient;

namespace Referral.Controllers.Patient
{
    [Route("api/[controller]")]
    public class PatientController : ControllerBase
    {
           private readonly PatientService _patientService;
        
           public PatientController(PatientService patientService)
            {
                 _patientService = patientService;
            }

           [HttpPost]
           public async Task<IActionResult> Post([FromBody] PatientDto input)
           {
               PatientDto patient = await _patientService.CreatePatient(input);
               return Ok(patient);
           }
           
           [HttpGet]
           public async Task<List<PatientDto>> GetPatients()
           {
               List<PatientDto> patients = await _patientService.GetAllPatients();
               return patients;
           }
           
           [HttpGet("nric/{nric}")]
           public async Task<PatientDto> GetPatientByNric(string nric)
           {
               PatientDto patient = await _patientService.GetPatientByNric(nric);
               return patient;
           }
           
       [HttpPost("authenticate")]
        public async Task<IActionResult> Authenticate([FromBody] AuthenticateRequestPatient input)
        {
            var login = await _patientService.Authenticate(input);
            if (login != null)
            {
                var token = _patientService.generateJwtToken(login);
                AuthenticateResponsePatient response = new AuthenticateResponsePatient(login, token);
                return Ok(response);
            }
            else return BadRequest(new {message = "Username or password is incorrect"});
        } 
    }
}