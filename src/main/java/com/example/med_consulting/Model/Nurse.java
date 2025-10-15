package com.example.med_consulting.Model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "nurses")
@DiscriminatorValue("NURSE")
@PrimaryKeyJoinColumn(name = "user_id")
public class Nurse extends User {

    @OneToMany(mappedBy = "registeredBy", fetch = FetchType.LAZY)
    private List<Patient> registeredPatients = new ArrayList<>();

    public Nurse() {
        super();
    }

    public List<Patient> getRegisteredPatients() {
        return registeredPatients;
    }

    public void setRegisteredPatients(List<Patient> registeredPatients) {
        this.registeredPatients = registeredPatients;
    }
}