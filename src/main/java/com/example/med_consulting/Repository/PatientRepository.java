package com.example.med_consulting.Repository;

import com.example.med_consulting.Model.Patient;
import com.example.med_consulting.Model.User;
import com.example.med_consulting.Repository.Interfaces.PatientRepositoryInterface;
import com.example.med_consulting.Util.JPAUtil;
import jakarta.persistence.EntityManager;

import java.util.ArrayList;
import java.util.List;

public class PatientRepository implements PatientRepositoryInterface {

    private static final int PATIENTS_PER_PAGE = 12;

    public List<Patient> getPatientsByNurse(long nurseId) {
        EntityManager em = null;

        try {
            em = JPAUtil.getInstance().getEntityManager();

            return em.createQuery(
                    "SELECT p FROM Patient p WHERE p.registeredBy.id = :nurseId ORDER BY p.createdAt DESC",
                    Patient.class)
                    .setParameter("nurseId", nurseId)
                    .getResultList();

        } catch (Exception e) {
            System.out.println("ERROR: Failed to fetch patients for nurse ID " + nurseId + " - " + e.getMessage());
            return new ArrayList<>();

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Get paginated patients for a specific nurse
     * 
     * @param nurseId The nurse ID
     * @param page    Page number (1-based)
     * @return List of patients for the specified page
     */
    public List<Patient> getPatientsByNursePaginated(long nurseId, int page) {
        EntityManager em = null;

        try {
            em = JPAUtil.getInstance().getEntityManager();

            // Calculate offset (0-based for JPA)
            int offset = (page - 1) * PATIENTS_PER_PAGE;

            return em.createQuery(
                    "SELECT p FROM Patient p WHERE p.registeredBy.id = :nurseId ORDER BY p.createdAt DESC",
                    Patient.class)
                    .setParameter("nurseId", nurseId)
                    .setFirstResult(offset)
                    .setMaxResults(PATIENTS_PER_PAGE)
                    .getResultList();

        } catch (Exception e) {
            System.out.println(
                    "ERROR: Failed to fetch paginated patients for nurse ID " + nurseId + " - " + e.getMessage());
            return new ArrayList<>();

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Get total count of patients registered by a specific nurse
     * 
     * @param nurseId The nurse ID
     * @return Total number of patients
     */
    public long countPatientsByNurse(long nurseId) {
        EntityManager em = null;

        try {
            em = JPAUtil.getInstance().getEntityManager();

            return em.createQuery(
                    "SELECT COUNT(p) FROM Patient p WHERE p.registeredBy.id = :nurseId",
                    Long.class)
                    .setParameter("nurseId", nurseId)
                    .getSingleResult();

        } catch (Exception e) {
            System.out.println("ERROR: Failed to count patients for nurse ID " + nurseId + " - " + e.getMessage());
            return 0L;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Search patients by name, CIN, or phone number with pagination
     * 
     * @param nurseId     The nurse ID
     * @param searchQuery The search query
     * @param page        Page number (1-based)
     * @return List of matching patients for the specified page
     */
    public List<Patient> searchPatientsByNursePaginated(long nurseId, String searchQuery, int page) {
        EntityManager em = null;

        try {
            em = JPAUtil.getInstance().getEntityManager();

            // Calculate offset (0-based for JPA)
            int offset = (page - 1) * PATIENTS_PER_PAGE;

            String query = "SELECT p FROM Patient p WHERE p.registeredBy.id = :nurseId " +
                    "AND (LOWER(p.firstName) LIKE LOWER(:search) " +
                    "OR LOWER(p.lastName) LIKE LOWER(:search) " +
                    "OR LOWER(p.cin) LIKE LOWER(:search) " +
                    "OR LOWER(p.phoneNumber) LIKE LOWER(:search)) " +
                    "ORDER BY p.createdAt DESC";

            String searchPattern = "%" + searchQuery + "%";

            return em.createQuery(query, Patient.class)
                    .setParameter("nurseId", nurseId)
                    .setParameter("search", searchPattern)
                    .setFirstResult(offset)
                    .setMaxResults(PATIENTS_PER_PAGE)
                    .getResultList();

        } catch (Exception e) {
            System.out.println("ERROR: Failed to search patients - " + e.getMessage());
            return new ArrayList<>();

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Count search results for pagination
     * 
     * @param nurseId     The nurse ID
     * @param searchQuery The search query
     * @return Total number of matching patients
     */
    public long countSearchResults(long nurseId, String searchQuery) {
        EntityManager em = null;

        try {
            em = JPAUtil.getInstance().getEntityManager();

            String query = "SELECT COUNT(p) FROM Patient p WHERE p.registeredBy.id = :nurseId " +
                    "AND (LOWER(p.firstName) LIKE LOWER(:search) " +
                    "OR LOWER(p.lastName) LIKE LOWER(:search) " +
                    "OR LOWER(p.cin) LIKE LOWER(:search) " +
                    "OR LOWER(p.phoneNumber) LIKE LOWER(:search))";

            String searchPattern = "%" + searchQuery + "%";

            return em.createQuery(query, Long.class)
                    .setParameter("nurseId", nurseId)
                    .setParameter("search", searchPattern)
                    .getSingleResult();

        } catch (Exception e) {
            System.out.println("ERROR: Failed to count search results - " + e.getMessage());
            return 0L;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public User findUserById(Long userId) {
        EntityManager em = null;

        try {
            em = JPAUtil.getInstance().getEntityManager();

            if (em == null) {
                System.out.println("ERROR: EntityManager is null");
                return null;
            }

            return em.find(User.class, userId);

        } catch (Exception e) {
            System.out.println("ERROR: Failed to find user with ID " + userId + " - " + e.getMessage());
            return null;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}