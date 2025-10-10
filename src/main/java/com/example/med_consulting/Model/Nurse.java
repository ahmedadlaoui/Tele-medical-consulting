package com.example.med_consulting.Model;

import jakarta.persistence.*;

@Entity
@DiscriminatorValue("NURSE")
public class Nurse extends User {

    @Column
    private String licenseNumber;

    // Getters and Setters
    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }
}