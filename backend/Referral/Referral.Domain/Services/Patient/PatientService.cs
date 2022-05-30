using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Mapster;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Referral.Domain.Context;
using Referral.Domain.Helpers;
using Referral.Domain.Models.Patient;

namespace Referral.Domain.Services.Patient
{
    public class PatientService
    {
        
        private readonly RContext _rContext;
        private readonly AppSettings _appSettings;
        private readonly PasswordHasher _passwordHasher;

        public PatientService(RContext rContext, IOptions<AppSettings> appSettings, PasswordHasher passwordHasher)
        {
            _rContext = rContext;
            _appSettings = appSettings.Value;
            _passwordHasher = passwordHasher;
        }

        public async Task<PatientDto> CreatePatient(PatientDto input, Domain.Patient.Patient patient = null)
        {
            patient = new Domain.Patient.Patient();
            patient.Username = input.Username;
            patient.Password = _passwordHasher.Hash(input.Password);
            patient.PatientName = input.PatientName;
            patient.Address = input.Address;
            patient.Email = input.Email;
            patient.Gender = input.Gender;
            patient.Nric = input.Nric;
            patient.HomeNo = input.HomeNo;
            patient.MobileNo = input.MobileNo;
            _rContext.Patients.Add(patient);
            await _rContext.SaveChangesAsync();
            return patient.Adapt<PatientDto>();
        }

        public async Task<List<PatientDto>> GetAllPatients()
        {
            return await _rContext.Patients.AsQueryable().ProjectToType<PatientDto>().ToListAsync();
        }
        
        public async Task<PatientDto> GetPatientByNric(string nric)
        {
            return await _rContext.Patients.AsQueryable().Where(x=> x.Nric==nric).ProjectToType<PatientDto>().SingleOrDefaultAsync();
        }
        
        public async Task<PatientDto> Authenticate(AuthenticateRequestPatient input)
        {
            var correctLogin = _rContext.Patients.SingleOrDefault(x => x.Username == input.Username);
            bool checkPassword = correctLogin != null && _passwordHasher.Check(correctLogin.Password, input.Password);
            return checkPassword == true ? correctLogin.Adapt<PatientDto>() : null;
        }
        
        public string generateJwtToken(PatientDto patient)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes("Testing JWT Secret Key");
        
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] {new Claim("id", patient.Id.ToString())}),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}