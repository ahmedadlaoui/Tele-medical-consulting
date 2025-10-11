package com.example.med_consulting.Model;

import com.example.med_consulting.Model.Enum.Specialty;
import jakarta.persistence.*;

@Entity
@DiscriminatorValue("SPECIALIST")
public class Specialist extends User {

    @Enumerated(EnumType.STRING)
    @Column(nullable = true)
    private Specialty specialty;

    @Column(nullable = true)
    private Double consultationRate;

    // Getters and Setters

    public Specialty getSpecialty() { return specialty; }
    public void setSpecialty(Specialty specialty) { this.specialty = specialty; }

    public Double getConsultationRate() { return consultationRate; }
    public void setConsultationRate(Double consultationRate) { this.consultationRate = consultationRate; }
}