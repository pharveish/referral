﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Referral.Domain.Context;

#nullable disable

namespace Referral.Domain.Migrations
{
    [DbContext(typeof(RContext))]
    partial class RContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.0")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder, 1L, 1);

            modelBuilder.Entity("Referral.Domain.Domain.Delegate.Delegate", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("DelegateFromId")
                        .HasColumnType("int");

                    b.Property<int>("DelegateToId")
                        .HasColumnType("int");

                    b.Property<string>("Notes")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("DelegateFromId");

                    b.HasIndex("DelegateToId");

                    b.ToTable("Delegates");
                });

            modelBuilder.Entity("Referral.Domain.Domain.Doctor.Doctor", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Credentials")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Fax")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FbToken")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Hospital")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("MobilePhone")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("OfficePhone")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Password")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PracticeLocation")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Specialty")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Username")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Doctors");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Credentials = "MBBS",
                            Email = "user1@example.com",
                            Fax = "",
                            FbToken = "",
                            Hospital = "",
                            MobilePhone = "",
                            Name = "Dr. Ahmad Ali",
                            OfficePhone = "",
                            Password = "abc123",
                            PracticeLocation = "",
                            Specialty = "Cardiologist",
                            Username = "user1"
                        });
                });

            modelBuilder.Entity("Referral.Domain.Domain.Document.CompletedDocument", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("ContentType")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FileName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<long>("FileSize")
                        .HasColumnType("bigint");

                    b.Property<int>("ReferralId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("ReferralId");

                    b.ToTable("CompletedDocuments");
                });

            modelBuilder.Entity("Referral.Domain.Domain.Document.Document", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("ContentType")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FileName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<long>("FileSize")
                        .HasColumnType("bigint");

                    b.Property<int>("ReferralId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("ReferralId");

                    b.ToTable("Documents");
                });

            modelBuilder.Entity("Referral.Domain.Domain.Patient.Patient", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Address")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FbToken")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Gender")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("HomeNo")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("MobileNo")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Nric")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Password")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PatientName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Username")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Patients");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Address = "No 5, Jalan Laksamana 1/6, Taman Sutera Utama, 81200 Johor Bahru, Johor",
                            Email = "nadia@example.com",
                            FbToken = "",
                            Gender = "Female",
                            HomeNo = "07-4449921",
                            MobileNo = "017-4449921",
                            Nric = "001111-01-1213",
                            Password = "",
                            PatientName = "Nadia binti Ali",
                            Username = ""
                        });
                });

            modelBuilder.Entity("Referral.Domain.Domain.Referral.Referral", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<DateTime>("AppointmentDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("ClinicalHistory")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("CompletionMessage")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("DelegateId")
                        .HasColumnType("int");

                    b.Property<string>("Diagnosis")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("DoctorFromId")
                        .HasColumnType("int");

                    b.Property<int>("DoctorToId")
                        .HasColumnType("int");

                    b.Property<bool>("FollowUp")
                        .HasColumnType("bit");

                    b.Property<bool>("LaboratoryTest")
                        .HasColumnType("bit");

                    b.Property<string>("Notes")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("PatientId")
                        .HasColumnType("int");

                    b.Property<bool>("RadiologyExam")
                        .HasColumnType("bit");

                    b.Property<string>("Reason")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("ReferralDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("RejectionRemark")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Status")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("DelegateId");

                    b.HasIndex("DoctorFromId");

                    b.HasIndex("DoctorToId");

                    b.HasIndex("PatientId");

                    b.ToTable("Referrals");
                });

            modelBuilder.Entity("Referral.Domain.Domain.Delegate.Delegate", b =>
                {
                    b.HasOne("Referral.Domain.Domain.Doctor.Doctor", "DelegateFrom")
                        .WithMany()
                        .HasForeignKey("DelegateFromId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("Referral.Domain.Domain.Doctor.Doctor", "DelegateTo")
                        .WithMany()
                        .HasForeignKey("DelegateToId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("DelegateFrom");

                    b.Navigation("DelegateTo");
                });

            modelBuilder.Entity("Referral.Domain.Domain.Document.CompletedDocument", b =>
                {
                    b.HasOne("Referral.Domain.Domain.Referral.Referral", "Referral")
                        .WithMany()
                        .HasForeignKey("ReferralId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Referral");
                });

            modelBuilder.Entity("Referral.Domain.Domain.Document.Document", b =>
                {
                    b.HasOne("Referral.Domain.Domain.Referral.Referral", "Referral")
                        .WithMany()
                        .HasForeignKey("ReferralId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Referral");
                });

            modelBuilder.Entity("Referral.Domain.Domain.Referral.Referral", b =>
                {
                    b.HasOne("Referral.Domain.Domain.Delegate.Delegate", "Delegate")
                        .WithMany()
                        .HasForeignKey("DelegateId");

                    b.HasOne("Referral.Domain.Domain.Doctor.Doctor", "ReferredFrom")
                        .WithMany()
                        .HasForeignKey("DoctorFromId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("Referral.Domain.Domain.Doctor.Doctor", "ReferredTo")
                        .WithMany()
                        .HasForeignKey("DoctorToId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("Referral.Domain.Domain.Patient.Patient", "Patient")
                        .WithMany()
                        .HasForeignKey("PatientId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Delegate");

                    b.Navigation("Patient");

                    b.Navigation("ReferredFrom");

                    b.Navigation("ReferredTo");
                });
#pragma warning restore 612, 618
        }
    }
}
