using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Mapster;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Referral.Domain.Context;
using Referral.Domain.Helpers;
using Referral.Domain.Models.Delegate;

namespace Referral.Domain.Services.Delegate
{
    public class DelegateService
    {
        
        public static IWebHostEnvironment _environment;
        private readonly RContext _rContext;
        private readonly AppSettings _appSettings;
        
        public DelegateService(RContext rContext, IOptions<AppSettings> appSettings, IWebHostEnvironment environment)
        {
            _rContext = rContext;
            _appSettings = appSettings.Value;
            _environment = environment;
        }
        
        public async Task<DelegateDto> AddDelegate(DelegateDto input, Domain.Delegate.Delegate newDelegate=null)
        {
            newDelegate = new Domain.Delegate.Delegate();
            newDelegate.DelegateFromId = input.DelegateFromId;
            newDelegate.DelegateToId = input.DelegateToId;
            _rContext.Delegates.Add(newDelegate);
            await _rContext.SaveChangesAsync();
            return newDelegate.Adapt<DelegateDto>();
        }

        public async Task<List<DelegateDto>> GetDelegatesByDoctorId(int id)
        {
            return await _rContext.Delegates.AsQueryable()
                .Select(x => 
                    new
                    {
                        x.Id,
                        DelegateToId = x.DelegateTo.Id,
                        DelegateFromId = x.DelegateFrom.Id,
                        DelegateToName = x.DelegateTo.Name,
                        DelegateToSpecialty = x.DelegateTo.Specialty,
                        DelegateToCredentials = x.DelegateTo.Credentials,
                    }
                ).Where(x => x.DelegateFromId ==id)
                .ProjectToType<DelegateDto>()
                .ToListAsync();
        }
    }
}