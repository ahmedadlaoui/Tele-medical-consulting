package com.example.med_consulting.Util;

import com.example.med_consulting.Model.Patient;
import com.example.med_consulting.Model.VitalSigns;
import jakarta.servlet.http.HttpServletRequest;

public class VitalSignsMapper {

    /**
     * Maps HTTP request parameters to a VitalSigns entity
     * 
     * @param request The HTTP request containing form data
     * @param patient The patient for whom vital signs are being recorded
     * @return VitalSigns entity populated with request data
     */
    public static VitalSigns mapRequestToVitalSigns(HttpServletRequest request, Patient patient) {
        VitalSigns vitalSigns = new VitalSigns();

        try {
            // Required fields
            String temperature = request.getParameter("temperature");
            String systolic = request.getParameter("bloodPressureSystolic");
            String diastolic = request.getParameter("bloodPressureDiastolic");
            String pulseRate = request.getParameter("pulseRate");

            // Debug logging
            System.out.println("DEBUG - Received parameters:");
            System.out.println("  temperature: " + temperature);
            System.out.println("  systolic: " + systolic);
            System.out.println("  diastolic: " + diastolic);
            System.out.println("  pulseRate: " + pulseRate);

            if (temperature != null && !temperature.trim().isEmpty()) {
                vitalSigns.setTemperature(Double.parseDouble(temperature.trim()));
            } else {
                System.out.println("ERROR: Temperature is null or empty");
            }

            if (systolic != null && !systolic.trim().isEmpty()) {
                vitalSigns.setBloodPressureSystolic(Integer.parseInt(systolic.trim()));
            } else {
                System.out.println("ERROR: Systolic is null or empty");
            }

            if (diastolic != null && !diastolic.trim().isEmpty()) {
                vitalSigns.setBloodPressureDiastolic(Integer.parseInt(diastolic.trim()));
            } else {
                System.out.println("ERROR: Diastolic is null or empty");
            }

            if (pulseRate != null && !pulseRate.trim().isEmpty()) {
                vitalSigns.setPulseRate(Integer.parseInt(pulseRate.trim()));
            } else {
                System.out.println("ERROR: Pulse rate is null or empty");
            }

            // Optional fields
            String respiratoryRate = request.getParameter("respiratoryRate");
            if (respiratoryRate != null && !respiratoryRate.trim().isEmpty()) {
                vitalSigns.setRespiratoryRate(Integer.parseInt(respiratoryRate.trim()));
            }

            String oxygenSaturation = request.getParameter("oxygenSaturation");
            if (oxygenSaturation != null && !oxygenSaturation.trim().isEmpty()) {
                vitalSigns.setOxygenSaturation(Integer.parseInt(oxygenSaturation.trim()));
            }

            String weight = request.getParameter("weight");
            if (weight != null && !weight.trim().isEmpty()) {
                vitalSigns.setWeight(Double.parseDouble(weight.trim()));
            }

            String height = request.getParameter("height");
            if (height != null && !height.trim().isEmpty()) {
                vitalSigns.setHeight(Double.parseDouble(height.trim()));
            }

            String notes = request.getParameter("notes");
            if (notes != null && !notes.trim().isEmpty()) {
                vitalSigns.setNotes(notes.trim());
            }

            // Set the patient
            vitalSigns.setPatient(patient);

            // Debug: Print what was set
            System.out.println("DEBUG - VitalSigns object created:");
            System.out.println("  Temperature: " + vitalSigns.getTemperature());
            System.out.println("  BP Systolic: " + vitalSigns.getBloodPressureSystolic());
            System.out.println("  BP Diastolic: " + vitalSigns.getBloodPressureDiastolic());
            System.out.println("  Pulse Rate: " + vitalSigns.getPulseRate());
            System.out.println("  Respiratory Rate: " + vitalSigns.getRespiratoryRate());
            System.out.println("  O2 Saturation: " + vitalSigns.getOxygenSaturation());
            System.out.println("  Weight: " + vitalSigns.getWeight());
            System.out.println("  Height: " + vitalSigns.getHeight());

        } catch (NumberFormatException e) {
            System.out.println("ERROR: Invalid number format in vital signs data - " + e.getMessage());
            e.printStackTrace();
            return null;
        }

        return vitalSigns;
    }

    /**
     * Validates required fields for vital signs
     * 
     * @param vitalSigns The vital signs entity to validate
     * @return true if all required fields are present, false otherwise
     */
    public static boolean validateVitalSigns(VitalSigns vitalSigns) {
        if (vitalSigns == null) {
            return false;
        }

        // Check required fields
        if (vitalSigns.getTemperature() == null) {
            System.out.println("VALIDATION ERROR: Temperature is required");
            return false;
        }

        if (vitalSigns.getBloodPressureSystolic() == null) {
            System.out.println("VALIDATION ERROR: Blood pressure systolic is required");
            return false;
        }

        if (vitalSigns.getBloodPressureDiastolic() == null) {
            System.out.println("VALIDATION ERROR: Blood pressure diastolic is required");
            return false;
        }

        if (vitalSigns.getPulseRate() == null) {
            System.out.println("VALIDATION ERROR: Pulse rate is required");
            return false;
        }

        if (vitalSigns.getPatient() == null) {
            System.out.println("VALIDATION ERROR: Patient is required");
            return false;
        }

        // Validate ranges
        if (vitalSigns.getTemperature() < 30.0 || vitalSigns.getTemperature() > 45.0) {
            System.out.println("VALIDATION ERROR: Temperature out of valid range (30-45°C)");
            return false;
        }

        if (vitalSigns.getBloodPressureSystolic() < 50 || vitalSigns.getBloodPressureSystolic() > 250) {
            System.out.println("VALIDATION ERROR: Systolic blood pressure out of valid range (50-250)");
            return false;
        }

        if (vitalSigns.getBloodPressureDiastolic() < 30 || vitalSigns.getBloodPressureDiastolic() > 150) {
            System.out.println("VALIDATION ERROR: Diastolic blood pressure out of valid range (30-150)");
            return false;
        }

        if (vitalSigns.getPulseRate() < 30 || vitalSigns.getPulseRate() > 250) {
            System.out.println("VALIDATION ERROR: Pulse rate out of valid range (30-250 bpm)");
            return false;
        }

        // Validate optional fields if present
        if (vitalSigns.getOxygenSaturation() != null) {
            if (vitalSigns.getOxygenSaturation() < 0 || vitalSigns.getOxygenSaturation() > 100) {
                System.out.println("VALIDATION ERROR: Oxygen saturation out of valid range (0-100%)");
                return false;
            }
        }

        return true;
    }
}
