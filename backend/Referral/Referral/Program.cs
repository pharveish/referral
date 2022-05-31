using System;
using System.IO;
using System.Reflection;
using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Referral.Domain.Helpers;
using Referral.Domain.Services.Delegate;
using Referral.Domain.Services.Doctors;
using Referral.Domain.Services.Patient;
using Referral.Domain.Services.Referral;
using Referral.PushNotification;
using RContext = Referral.Domain.Context.RContext;

var builder = WebApplication.CreateBuilder(args);

//builder.WebHost.ConfigureKestrel(options => options.Listen(System.Net.IPAddress.Parse("10.211.96.111"), 5077));
//builder.WebHost.ConfigureKestrel(options => options.Listen(System.Net.IPAddress.Parse("192.168.118.219"), 5077));
builder.WebHost.ConfigureKestrel(options => options.Listen(System.Net.IPAddress.Parse("0.0.0.0"), 5077));
//builder.WebHost.ConfigureKestrel(options => options.Listen(System.Net.IPAddress.Parse("10.211.97.186"), 5077));
//builder.WebHost.ConfigureKestrel(options => options.Listen(System.Net.IPAddress.Parse("10.211.103.179"), 5077));


//ADD SERVICES
builder.Services.AddSingleton(new PasswordHasher());
builder.Services.AddScoped<DoctorService>(); 
builder.Services.AddScoped<ReferralService>(); 
builder.Services.AddScoped<PatientService>(); 
builder.Services.AddScoped<DelegateService>(); 
//builder.Services.AddScoped<PushNotification>(); 


builder.Services.AddControllers();
builder.Services.AddDbContext<RContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"), b=> b.MigrationsAssembly("Referral.Domain"));
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
var defaultApp = FirebaseApp.Create(new AppOptions()
{
    Credential = GoogleCredential.FromFile(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "key.json")),
});
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();

app.UseAuthorization();

app.UseStaticFiles();

app.MapControllers();

app.Run();
