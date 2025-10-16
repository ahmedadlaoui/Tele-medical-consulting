package com.example.med_consulting.Service;

import com.example.med_consulting.DAO.VitalSignsDAO;
import com.example.med_consulting.Model.VitalSigns;

public class VitalSignsService {

    private final VitalSignsDAO vitalSignsDAO;

    public VitalSignsService() {
        this.vitalSignsDAO = new VitalSignsDAO();
    }

    /**
     * Records new vital signs for a patient
     * 
     * @param vitalSigns The vital signs to record
     * @return true if successfully saved, false otherwise
     */
    public boolean recordVitalSigns(VitalSigns vitalSigns) {
        try {
            if (vitalSigns == null) {
                System.out.println("ERROR: VitalSigns object is null");
                return false;
            }

            if (vitalSigns.getPatient() == null) {
                System.out.println("ERROR: Patient is required for vital signs");
                return false;
            }

            VitalSigns savedVitalSigns = vitalSignsDAO.save(vitalSigns);

            if (savedVitalSigns != null) {
                System.out.println("Vital signs recorded successfully - ID: " + savedVitalSigns.getId());
                return true;
            }

            System.out.println("ERROR: Failed to save vital signs");
            return false;

        } catch (Exception e) {
            System.out.println("ERROR: Failed to record vital signs - " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
