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
}