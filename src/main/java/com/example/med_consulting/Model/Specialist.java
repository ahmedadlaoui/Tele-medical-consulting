package com.example.med_consulting.Model;

import com.example.med_consulting.Model.Enum.Specialty;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "specialists")
@DiscriminatorValue("SPECIALIST")
@PrimaryKeyJoinColumn(name = "user_id")
public class Specialist extends User {

    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private Specialty specialty;

    @OneToMany(mappedBy = "assignedSpecialist", fetch = FetchType.LAZY)
    private List<ExpertiseRequest> assignedExpertiseRequests = new ArrayList<>();

    @OneToMany(mappedBy = "doctor", fetch = FetchType.LAZY)
    private List<TimeSlot> availableTimeSlots = new ArrayList<>();

    public Specialist() {
        super();
    }

    public Specialty getSpecialty() {
        return specialty;
    }

    public void setSpecialty(Specialty specialty) {
        this.specialty = specialty;
    }

    public List<ExpertiseRequest> getAssignedExpertiseRequests() {
        return assignedExpertiseRequests;
    }

    public void setAssignedExpertiseRequests(List<ExpertiseRequest> assignedExpertiseRequests) {
        this.assignedExpertiseRequests = assignedExpertiseRequests;
    }

    public List<TimeSlot> getAvailableTimeSlots() {
        return availableTimeSlots;
    }

    public void setAvailableTimeSlots(List<TimeSlot> availableTimeSlots) {
        this.availableTimeSlots = availableTimeSlots;
    }
}