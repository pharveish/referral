using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Referral.Domain.Models.Doctor;
using Referral.Domain.Services.Doctors;

namespace Referral.Controllers.Doctor
{
    [Route("api/[controller]")]
    public class DoctorController : ControllerBase
    {
        private readonly DoctorService _doctorService;

        public DoctorController(DoctorService doctorService)
        {
            _doctorService = doctorService;
        }

        [HttpGet]
        public Task<List<Domain.Domain.Doctor.Doctor>> GetAllDoctors()
        {
            return _doctorService.GetDoctors();
        }
        
        [HttpGet("{id}")]
        public Task<DoctorDTO> GetDoctorById(int id)
        {
            return _doctorService.GetDoctorById(id);
        }
        
        [HttpGet("specialty/{specialty}")]
        public Task<List<Domain.Domain.Doctor.Doctor>> GetDoctorsBySpecialty(string specialty)
        {
            return _doctorService.GetDoctorsBySpecialty(specialty);
        }
        
        [HttpGet("hospital/{hospital}")]
        public Task<List<Domain.Domain.Doctor.Doctor>> GetDoctorsByHospital(string hospital)
        {
            return _doctorService.GetDoctorsByHospital(hospital);
        }
        
       [HttpPost("authenticate")]
        public async Task<IActionResult> Authenticate([FromBody] AuthenticateRequest input)
        {
            var login = await _doctorService.Authenticate(input);
            if (login != null)
            {
                var token = _doctorService.generateJwtToken(login);
                AuthenticateResponse response = new AuthenticateResponse(login, token);
                return Ok(response);
            }
            else return BadRequest(new {message = "Username or password is incorrect"});
        } 
        
        [HttpPut("bindToken/{id}")]
        public async Task<IActionResult> BindToken(int id, [FromBody] DoctorDTO input)
        {
            DoctorDTO doctor = await _doctorService.BindToken(id, input);
            return Ok(doctor);
        }
        
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] DoctorDTO input)
        {
            DoctorDTO doctor = await _doctorService.CreateDoctor(input);
            return Ok(doctor);
        }
    }
}