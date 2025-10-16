package com.example.med_consulting.DAO;

import com.example.med_consulting.DAO.Interfaces.VitalSignsDAOInterface;
import com.example.med_consulting.Model.Patient;
import com.example.med_consulting.Model.VitalSigns;
import com.example.med_consulting.Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class VitalSignsDAO implements VitalSignsDAOInterface {

    @Override
    public VitalSigns save(VitalSigns vitalSigns) {
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

            // Reattach the Patient entity if it exists
            if (vitalSigns.getPatient() != null && vitalSigns.getPatient().getId() != null) {
                Patient managedPatient = em.find(Patient.class, vitalSigns.getPatient().getId());
                if (managedPatient != null) {
                    vitalSigns.setPatient(managedPatient);
                } else {
                    System.out.println("ERROR: Patient not found with ID: " + vitalSigns.getPatient().getId());
                    transaction.rollback();
                    return null;
                }
            }

            // Persist new vital signs
            em.persist(vitalSigns);

            transaction.commit();
            System.out.println("Vital signs saved successfully - ID: " + vitalSigns.getId());
            return vitalSigns;

        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            System.out.println("ERROR saving vital signs: " + e.getMessage());
            e.printStackTrace();
            return null;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
