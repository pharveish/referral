using System.Linq;
using System.Reflection.Metadata;
using Microsoft.EntityFrameworkCore;
using Referral.Domain.Domain.Delegate;
using Referral.Domain.Domain.Doctor;
using Referral.Domain.Domain.Document;
using Referral.Domain.Domain.Patient;
using Document = Referral.Domain.Domain.Document.Document;

namespace Referral.Domain.Context
{
    public class RContext : DbContext 
    {
        public RContext(DbContextOptions<RContext> options) : base(options) { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseLazyLoadingProxies();
        }
        
        public DbSet<Doctor> Doctors { get; set; }
        public DbSet<Patient> Patients { get; set; }
        public DbSet<Domain.Referral.Referral> Referrals { get; set; }
        public DbSet<Document> Documents { get; set; }
        public DbSet<CompletedDocument> CompletedDocuments { get; set; }
        
        public DbSet<Delegate> Delegates { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        modelBuilder.Entity<Domain.Referral.Referral>()
    .HasOne(e => e.ReferredFrom)
    .WithMany()
    .OnDelete(DeleteBehavior.Restrict);

modelBuilder.Entity<Domain.Referral.Referral>()
    .HasOne(e => e.ReferredTo)
    .WithMany()
    .OnDelete(DeleteBehavior.Restrict);
        modelBuilder.Entity<Delegate>()
    .HasOne(e => e.DelegateFrom)
    .WithMany()
    .OnDelete(DeleteBehavior.Restrict);

modelBuilder.Entity<Delegate>()
    .HasOne(e => e.DelegateTo)
    .WithMany()
    .OnDelete(DeleteBehavior.Restrict);

            seedDoctor(modelBuilder);
            
        }
            
        
        

        private void seedDoctor(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Doctor>().HasData(new Doctor
            {
                Id = 1,
                Username = "user1",
                Password = "abc123",
                Credentials = "MBBS",
                Email = "user1@example.com",
                Name = "Dr. Ahmad Ali",
                Specialty = "Cardiologist",
            });
            modelBuilder.Entity<Patient>().HasData(new Patient
            {
                Id = 1,
                Nric = "001111-01-1213",
                PatientName = "Nadia binti Ali",
                Gender = "Female",
                HomeNo = "07-4449921",
                MobileNo = "017-4449921",
                Email = "nadia@example.com",
                Address = "No 5, Jalan Laksamana 1/6, Taman Sutera Utama, 81200 Johor Bahru, Johor",
            });
        }
    }
}