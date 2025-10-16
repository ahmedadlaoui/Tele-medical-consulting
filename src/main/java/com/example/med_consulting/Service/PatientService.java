package com.example.med_consulting.Service;

import com.example.med_consulting.DAO.PatientDAO;
import com.example.med_consulting.Model.Patient;
import com.example.med_consulting.Model.User;
import com.example.med_consulting.Repository.PatientRepository;

import java.util.List;

public class PatientService {

    private final PatientRepository patientRepository;
    private final PatientDAO patientDAO;

    public PatientService() {
        this.patientRepository = new PatientRepository();
        this.patientDAO = new PatientDAO();
    }

    public List<Patient> getAllPatientsByCurrentNurse(long nurseId) {
        return patientRepository.getPatientsByNurse(nurseId);
    }

    /**
     * Get paginated patients for a specific nurse
     * 
     * @param nurseId The nurse ID
     * @param page    Page number (1-based)
     * @return List of patients for the specified page
     */
    public List<Patient> getPatientsByNursePaginated(long nurseId, int page) {
        return patientRepository.getPatientsByNursePaginated(nurseId, page);
    }

    /**
     * Get total count of patients for pagination
     * 
     * @param nurseId The nurse ID
     * @return Total number of patients
     */
    public long countPatientsByNurse(long nurseId) {
        return patientRepository.countPatientsByNurse(nurseId);
    }

    /**
     * Calculate total number of pages
     * 
     * @param nurseId The nurse ID
     * @return Total number of pages (12 patients per page)
     */
    public int getTotalPages(long nurseId) {
        long totalPatients = countPatientsByNurse(nurseId);
        return (int) Math.ceil((double) totalPatients / 12);
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
        return patientRepository.searchPatientsByNursePaginated(nurseId, searchQuery, page);
    }

    /**
     * Count search results for pagination
     * 
     * @param nurseId     The nurse ID
     * @param searchQuery The search query
     * @return Total number of matching patients
     */
    public long countSearchResults(long nurseId, String searchQuery) {
        return patientRepository.countSearchResults(nurseId, searchQuery);
    }

    public boolean registerPatient(Patient patient, long nurseId) {
        try {
            User nurse = patientRepository.findUserById(nurseId);

            if (nurse == null) {
                System.out.println("ERROR: Nurse not found with ID: " + nurseId);
                return false;
            }

            patient.setRegisteredBy(nurse);

            Patient savedPatient = patientDAO.save(patient);

            if (savedPatient != null) {
                System.out.println("Patient registered successfully - ID: " + savedPatient.getId());
                return true;
            }

            System.out.println("ERROR: Failed to save patient");
            return false;

        } catch (Exception e) {
            System.out.println("ERROR: Failed to register patient - " + e.getMessage());
            return false;
        }
    }

    public Patient getPatientById(Long patientId) {
        return patientDAO.findById(patientId);
    }

    /**
     * Get patient by ID with vital signs history eagerly loaded
     * 
     * @param patientId The patient ID
     * @return Patient with vital signs loaded
     */
    public Patient getPatientWithVitalSigns(Long patientId) {
        return patientDAO.findByIdWithVitalSigns(patientId);
    }
}