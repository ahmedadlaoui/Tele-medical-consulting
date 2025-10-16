package com.example.med_consulting.DAO;

import com.example.med_consulting.DAO.Interfaces.PatientDAOInterface;
import com.example.med_consulting.Model.Patient;
import com.example.med_consulting.Model.User;
import com.example.med_consulting.Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class PatientDAO implements PatientDAOInterface {

    public Patient save(Patient patient) {
        EntityManager em = null;
        EntityTransaction transaction = null;

        try {
            em = JPAUtil.getInstance().getEntityManager();

            if (em == null) {
                System.out.println("ERROR: EntityManager is null");
                return null;
            }

            transaction = em.getTransaction();
            transaction.begin();

            // Reattach the User entity (registeredBy) if it exists
            if (patient.getRegisteredBy() != null && patient.getRegisteredBy().getId() != null) {
                User managedUser = em.find(User.class, patient.getRegisteredBy().getId());
                if (managedUser != null) {
                    patient.setRegisteredBy(managedUser);
                }
            }

            // Persist new or merge existing patient
            if (patient.getId() == null) {
                em.persist(patient);
            } else {
                patient = em.merge(patient);
            }

            transaction.commit();
            System.out.println("Patient saved successfully - ID: " + patient.getId());
            return patient;

        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            System.out.println("ERROR saving patient: " + e.getMessage());
            return null;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public Patient findById(Long patientId) {
        EntityManager em = null;

        try {
            em = JPAUtil.getInstance().getEntityManager();

            if (em == null) {
                System.out.println("ERROR: EntityManager is null");
                return null;
            }

            return em.find(Patient.class, patientId);

        } catch (Exception e) {
            System.out.println("ERROR finding patient by ID " + patientId + ": " + e.getMessage());
            return null;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Find patient by ID with vital signs history eagerly loaded
     * 
     * @param patientId The patient ID
     * @return Patient with vital signs loaded
     */
    public Patient findByIdWithVitalSigns(Long patientId) {
        EntityManager em = null;

        try {
            em = JPAUtil.getInstance().getEntityManager();

            if (em == null) {
                System.out.println("ERROR: EntityManager is null");
                return null;
            }

            // Use JPQL with JOIN FETCH to eagerly load vital signs
            Patient patient = em.createQuery(
                    "SELECT p FROM Patient p LEFT JOIN FETCH p.vitalSignsHistory v WHERE p.id = :patientId ORDER BY v.recordedAt DESC",
                    Patient.class)
                    .setParameter("patientId", patientId)
                    .getSingleResult();

            return patient;

        } catch (Exception e) {
            System.out.println("ERROR finding patient with vital signs by ID " + patientId + ": " + e.getMessage());
            return null;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}