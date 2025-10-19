package com.example.med_consulting.Model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "general_practitioners")
@DiscriminatorValue("GENERAL_PRACTITIONER")
@PrimaryKeyJoinColumn(name = "user_id")
public class GeneralPractitioner extends User {

    @OneToMany(mappedBy = "assignedGP", fetch = FetchType.LAZY)
    private List<WaitingQueue> assignedQueue = new ArrayList<>();

    @OneToMany(mappedBy = "performedBy", fetch = FetchType.LAZY)
    private List<Consultation> consultations = new ArrayList<>();

    @OneToMany(mappedBy = "requestedBy", fetch = FetchType.LAZY)
    private List<ExpertiseRequest> expertiseRequests = new ArrayList<>();

    @OneToMany(mappedBy = "doctor", fetch = FetchType.LAZY)
    private List<TimeSlot> availableTimeSlots = new ArrayList<>();

    public GeneralPractitioner() {
        super();
    }

    public List<WaitingQueue> getAssignedQueue() {
        return assignedQueue;
    }

    public void setAssignedQueue(List<WaitingQueue> assignedQueue) {
        this.assignedQueue = assignedQueue;
    }

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }

    public List<ExpertiseRequest> getExpertiseRequests() {
        return expertiseRequests;
    }

    public void setExpertiseRequests(List<ExpertiseRequest> expertiseRequests) {
        this.expertiseRequests = expertiseRequests;
    }

    public List<TimeSlot> getAvailableTimeSlots() {
        return availableTimeSlots;
    }

    public void setAvailableTimeSlots(List<TimeSlot> availableTimeSlots) {
        this.availableTimeSlots = availableTimeSlots;
    }

    public String toString() {
        return "Dr. " + getFirstName() + " " + getLastName() +
                " | Email: " + getEmail() +
                " | License: " + getLicenseNumber();
    }
}