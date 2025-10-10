package com.example.med_consulting.Model;

import com.example.med_consulting.Model.Enum.ExpertiseStatus;
import com.example.med_consulting.Model.Enum.PriorityLevel;
import com.example.med_consulting.Model.Enum.Specialty;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "expertise_requests")
public class ExpertiseRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "consultation_id", nullable = false)
    private Consultation consultation;

    @ManyToOne
    @JoinColumn(name = "specialist_id", nullable = false)
    private Specialist specialist;

    @ManyToOne
    @JoinColumn(name = "time_slot_id")
    private TimeSlot timeSlot;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Specialty requiredSpecialty;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String question;

    @Column(columnDefinition = "TEXT")
    private String patientData;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PriorityLevel priority;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ExpertiseStatus status;

    @Column(columnDefinition = "TEXT")
    private String specialistOpinion;

    @Column(columnDefinition = "TEXT")
    private String recommendations;

    @Column(nullable = false)
    private LocalDateTime requestedAt;

    @PrePersist
    protected void onCreate() {
        requestedAt = LocalDateTime.now();
        status = ExpertiseStatus.PENDING;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Consultation getConsultation() { return consultation; }
    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }

    public Specialist getSpecialist() { return specialist; }
    public void setSpecialist(Specialist specialist) { this.specialist = specialist; }

    public TimeSlot getTimeSlot() { return timeSlot; }
    public void setTimeSlot(TimeSlot timeSlot) { this.timeSlot = timeSlot; }

    public Specialty getRequiredSpecialty() { return requiredSpecialty; }
    public void setRequiredSpecialty(Specialty requiredSpecialty) {
        this.requiredSpecialty = requiredSpecialty;
    }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public String getPatientData() { return patientData; }
    public void setPatientData(String patientData) { this.patientData = patientData; }

    public PriorityLevel getPriority() { return priority; }
    public void setPriority(PriorityLevel priority) { this.priority = priority; }

    public ExpertiseStatus getStatus() { return status; }
    public void setStatus(ExpertiseStatus status) { this.status = status; }

    public String getSpecialistOpinion() { return specialistOpinion; }
    public void setSpecialistOpinion(String specialistOpinion) {
        this.specialistOpinion = specialistOpinion;
    }

    public String getRecommendations() { return recommendations; }
    public void setRecommendations(String recommendations) {
        this.recommendations = recommendations;
    }

    public LocalDateTime getRequestedAt() { return requestedAt; }
    public void setRequestedAt(LocalDateTime requestedAt) {
        this.requestedAt = requestedAt;
    }
}