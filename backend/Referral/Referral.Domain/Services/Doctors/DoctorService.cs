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
using Referral.Domain.Domain.Doctor;
using Referral.Domain.Helpers;
using Referral.Domain.Models.Doctor;

namespace Referral.Domain.Services.Doctors
{
    public class DoctorService
    {
        private readonly RContext _rContext;
        private readonly AppSettings _appSettings;
        private readonly PasswordHasher _passwordHasher;

        public DoctorService(RContext rContext, PasswordHasher passwordHasher, IOptions<AppSettings> appSettings)
        {
            _rContext = rContext;
            _passwordHasher = passwordHasher;
            _appSettings = appSettings.Value;
        }

        public async Task<DoctorDTO> CreateDoctor(DoctorDTO input, Doctor doctor = null)
        {
            doctor = new Doctor();
            doctor.Username = input.Username;
            doctor.Password = _passwordHasher.Hash(input.Password);
            doctor.Name = input.Name;
            doctor.Credentials = input.Credentials;
            doctor.Specialty = input.Specialty;
            doctor.Email = input.Email;
            doctor.Hospital = input.Hospital;
            doctor.OfficePhone = input.OfficePhone;
            doctor.MobilePhone = input.MobilePhone;
            doctor.Fax = input.Fax;
            doctor.PracticeLocation = input.PracticeLocation;
            _rContext.Doctors.Add(doctor);
            await _rContext.SaveChangesAsync();
            return doctor.Adapt<DoctorDTO>();
        }
        
        public async Task<List<Doctor>> GetDoctors()
        {
            return await _rContext.Doctors.AsQueryable().ProjectToType<Doctor>().ToListAsync();
        }
        
        public async Task<List<Doctor>> GetDoctorsBySpecialty(String specialty)
        {
            return await _rContext.Doctors.AsQueryable().Where(x=> x.Specialty==specialty).ProjectToType<Doctor>().ToListAsync();
        }
        
        public async Task<List<Doctor>> GetDoctorsByHospital(String hospital)
        {
            return await _rContext.Doctors.AsQueryable().Where(x=> x.Hospital==hospital).ProjectToType<Doctor>().ToListAsync();
        }
        
        public async Task<DoctorDTO> GetDoctorById(int id)
        {
            return await _rContext.Doctors.AsQueryable().Where(x=> x.Id==id).ProjectToType<DoctorDTO>().SingleOrDefaultAsync();
        }

        public async Task<DoctorDTO> Authenticate(AuthenticateRequest input)
        {
            var correctLogin = _rContext.Doctors.SingleOrDefault(x => x.Username == input.Username);
            bool checkPassword = correctLogin != null && _passwordHasher.Check(correctLogin.Password, input.Password);
            return checkPassword == true ? correctLogin.Adapt<DoctorDTO>() : null;
        }
        public string generateJwtToken(DoctorDTO doctor)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes("Testing JWT Secret Key");
        
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] {new Claim("id", doctor.Id.ToString())}),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
        
        public async Task<DoctorDTO> BindToken(int id, DoctorDTO input)
        {
            Doctor doctor = await _rContext.Doctors.FirstOrDefaultAsync(x => x.Id == id);
            doctor.FbToken = input.FbToken;
            _rContext.Doctors.Update(doctor);
            await _rContext.SaveChangesAsync();
            return doctor.Adapt<DoctorDTO>();
        }
        
        
    }

}