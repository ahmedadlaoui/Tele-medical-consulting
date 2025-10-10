package com.example.med_consulting.Model;

import com.example.med_consulting.Model.Enum.ProcedureType;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "medical_procedures")
public class MedicalProcedure {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "consultation_id", nullable = false)
    private Consultation consultation;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ProcedureType procedureType;

    @Column(nullable = false)
    private Double cost;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private LocalDateTime performedAt;

    @PrePersist
    protected void onCreate() {
        performedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Consultation getConsultation() { return consultation; }
    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }

    public ProcedureType getProcedureType() { return procedureType; }
    public void setProcedureType(ProcedureType procedureType) {
        this.procedureType = procedureType;
    }

    public Double getCost() { return cost; }
    public void setCost(Double cost) { this.cost = cost; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDateTime getPerformedAt() { return performedAt; }
    public void setPerformedAt(LocalDateTime performedAt) {
        this.performedAt = performedAt;
    }
}