package com.example.med_consulting.Controller;

import com.example.med_consulting.Model.Enum.UserRole;
import com.example.med_consulting.Model.Patient;
import com.example.med_consulting.Model.VitalSigns;
import com.example.med_consulting.Service.PatientService;
import com.example.med_consulting.Service.VitalSignsService;
import com.example.med_consulting.Util.VitalSignsMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/nurse/record-vital-signs")
public class RecordVitalSignsServlet extends HttpServlet {

    private final VitalSignsService vitalSignsService = new VitalSignsService();
    private final PatientService patientService = new PatientService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isValidNurseSession(request, response)) {
            return;
        }

        String patientIdParam = request.getParameter("patientId");

        if (patientIdParam == null || patientIdParam.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Patient ID is missing.");
            response.sendRedirect(request.getContextPath() + "/nurse/patients");
            return;
        }

        try {
            Long patientId = Long.parseLong(patientIdParam);

            // Fetch patient from database
            Patient patient = patientService.getPatientById(patientId);

            if (patient == null) {
                request.getSession().setAttribute("errorMessage", "Patient not found.");
                response.sendRedirect(request.getContextPath() + "/nurse/patients");
                return;
            }

            VitalSigns vitalSigns = VitalSignsMapper.mapRequestToVitalSigns(request, patient);

            if (vitalSigns == null) {
                request.getSession().setAttribute("errorMessage", "Invalid data format. Please check your input.");
                response.sendRedirect(request.getContextPath() + "/nurse/patient-detail?id=" + patientId);
                return;
            }

            if (!VitalSignsMapper.validateVitalSigns(vitalSigns)) {
                request.getSession().setAttribute("errorMessage",
                        "Validation failed. Please check vital signs values.");
                response.sendRedirect(request.getContextPath() + "/nurse/patient-detail?id=" + patientId);
                return;
            }

            boolean success = vitalSignsService.recordVitalSigns(vitalSigns);

            if (success) {
                request.getSession().setAttribute("successMessage", "Vital signs recorded successfully!");
                response.sendRedirect(request.getContextPath() + "/nurse/patient-detail?id=" + patientId);
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to save vital signs. Please try again.");
                response.sendRedirect(request.getContextPath() + "/nurse/patient-detail?id=" + patientId);
            }

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid patient ID format.");
            response.sendRedirect(request.getContextPath() + "/nurse/patients");
        } catch (Exception e) {
            System.out.println("ERROR in RecordVitalSignsServlet: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "System error occurred. Please try again.");
            response.sendRedirect(request.getContextPath() + "/nurse/patients");
        }
    }

    /**
     * Validate if the session belongs to an authenticated nurse
     */
    private boolean isValidNurseSession(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return false;
        }

        UserRole userRole = (UserRole) session.getAttribute("userRole");
        if (userRole != UserRole.NURSE) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return false;
        }

        return true;
    }
}
