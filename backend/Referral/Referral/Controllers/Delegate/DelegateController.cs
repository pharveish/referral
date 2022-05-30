using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Referral.Domain.Models.Delegate;
using Referral.Domain.Services.Delegate;

namespace Referral.Controllers.Delegate
{
    [Route("api/[controller]")]
    public class DelegateController : ControllerBase
    {
        private readonly DelegateService _delegateService;
        public static IWebHostEnvironment _environment;
        
        public DelegateController(DelegateService delegateService, IWebHostEnvironment environment)
        {
            _delegateService = delegateService;
            _environment = environment;
        }
        
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] DelegateDto input)
        {
            DelegateDto delegateDto = await _delegateService.AddDelegate(input);
            return Ok(delegateDto);
        }
        
        [HttpGet("delegates/{id}")]
        public async Task<List<DelegateDto>> GetDelegatesByDoctorId(int id)
        {
            List<DelegateDto> delegateDtos = await _delegateService.GetDelegatesByDoctorId(id);
            return delegateDtos;
        }
        
    }
}