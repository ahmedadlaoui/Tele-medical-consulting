package com.example.med_consulting.Util;

import com.example.med_consulting.Model.Enum.Gender;
import com.example.med_consulting.Model.Patient;
import jakarta.servlet.http.HttpServletRequest;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class PatientMapper {
    private final HttpServletRequest request;

    public PatientMapper(HttpServletRequest request) {
        this.request = request;
    }

    public Patient buildPatientFromRequest() {
        try {
            // Log all received parameters for debugging
            System.out.println("=== Patient Registration - Received Parameters ===");
            request.getParameterMap().forEach((key, values) -> {
                System.out.println(key + " = " + (values != null && values.length > 0 ? values[0] : "null"));
            });

            if (!areRequiredFieldsPresent()) {
                System.out.println("ERROR: Missing required fields");
                System.out.println("  CIN: " + request.getParameter("cin"));
                System.out.println("  First Name: " + request.getParameter("firstName"));
                System.out.println("  Last Name: " + request.getParameter("lastName"));
                System.out.println("  Date of Birth: " + request.getParameter("dateOfBirth"));
                System.out.println("  Gender: " + request.getParameter("gender"));
                return null;
            }

            Patient patient = new Patient();

            // Required fields
            patient.setCin(getParameter("cin"));
            patient.setFirstName(getParameter("firstName"));
            patient.setLastName(getParameter("lastName"));
            patient.setDateOfBirth(parseDateOfBirth());
            patient.setGender(parseGender());

            // Optional fields (will be null if not provided)
            patient.setPhoneNumber(getParameter("phoneNumber"));
            patient.setAddress(getParameter("address"));
            patient.setEmergencyContact(getParameter("emergencyContact"));
            patient.setSocialSecurityNumber(getParameter("socialSecurityNumber"));
            patient.setInsuranceProvider(getParameter("insuranceProvider"));
            patient.setMedicalHistory(getParameter("medicalHistory"));
            patient.setAllergies(getParameter("allergies"));
            patient.setCurrentTreatments(getParameter("currentTreatments"));

            // NOTE: Profile picture is handled separately in servlet (file upload)
            // It will be set by the servlet after successful file upload

            System.out.println("SUCCESS: Patient object built successfully");
            return patient;

        } catch (Exception e) {
            System.out.println("ERROR: Failed to build patient - " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    private boolean areRequiredFieldsPresent() {
        String cin = request.getParameter("cin");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");

        return cin != null && !cin.trim().isEmpty() &&
                firstName != null && !firstName.trim().isEmpty() &&
                lastName != null && !lastName.trim().isEmpty() &&
                dateOfBirth != null && !dateOfBirth.trim().isEmpty() &&
                gender != null && !gender.trim().isEmpty();
    }

    private String getParameter(String name) {
        String value = request.getParameter(name);
        return value != null && !value.trim().isEmpty() ? value.trim() : null;
    }

    private LocalDate parseDateOfBirth() {
        String dateStr = getParameter("dateOfBirth");
        if (dateStr == null || dateStr.isEmpty()) {
            throw new IllegalArgumentException("Date of birth is required");
        }

        try {
            return LocalDate.parse(dateStr);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Invalid date format: " + dateStr);
        }
    }

    private Gender parseGender() {
        String genderStr = getParameter("gender");
        if (genderStr == null || genderStr.isEmpty()) {
            throw new IllegalArgumentException("Gender is required");
        }

        try {
            return Gender.valueOf(genderStr.toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid gender value: " + genderStr);
        }
    }
}