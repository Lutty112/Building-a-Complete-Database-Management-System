# Building-a-Complete-Database-Management-System

💡 Project Title: Clinic Appointment and Patient Management System


🎯 Objective:
Design and implement a relational database for managing clinic appointments, patients, doctors, and billing. This system will track:

Patients’ medical information

Doctors and specializations

Appointment scheduling

Treatments given

Payments and billing

📘 Database Entities (Tables)
Patients – Stores patient details

Doctors – Stores doctor details and specialization

Appointments – Handles booking and visit tracking

Treatments – Records treatments for appointments

Billing – Manages payments and billing

Doctor_Specialization – Handles M:M between Doctors and Specializations

🔗 Key Relationships
One doctor can have many appointments → 1:M

One patient can have many appointments → 1:M

One appointment can include multiple treatments → 1:M

One doctor can have multiple specializations → M:M
