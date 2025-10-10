package com.example.med_consulting.Model;

import com.example.med_consulting.Model.Enum.Specialty;
import jakarta.persistence.*;

@Entity
@DiscriminatorValue("SPECIALIST")
public class Specialist extends User {

    @Column
    private String licenseNumber;

    @Enumerated(EnumType.STRING)
    @Column
    private Specialty specialty;

    @Column
    private Double consultationRate;

    // Getters and Setters
    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }

    public Specialty getSpecialty() { return specialty; }
    public void setSpecialty(Specialty specialty) { this.specialty = specialty; }

    public Double getConsultationRate() { return consultationRate; }
    public void setConsultationRate(Double consultationRate) { this.consultationRate = consultationRate; }
}