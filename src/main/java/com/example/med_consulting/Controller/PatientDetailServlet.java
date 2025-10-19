package com.example.med_consulting.Controller;

import com.example.med_consulting.Model.Enum.UserRole;
import com.example.med_consulting.Model.GeneralPractitioner;
import com.example.med_consulting.Model.Patient;
import com.example.med_consulting.Service.GpService;
import com.example.med_consulting.Service.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/nurse/patient-detail")
public class PatientDetailServlet extends HttpServlet {

    private final PatientService patientService = new PatientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isValidNurseSession(request, response)) {
            return;
        }
        String patientIdParam = request.getParameter("id");

        if (patientIdParam == null || patientIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/nurse/patients");
            return;
        }

        try {
            Long patientId = Long.parseLong(patientIdParam);

            Patient patient = patientService.getPatientWithVitalSigns(patientId);

            GpService gpService = new GpService();
            List<GeneralPractitioner> GeneralPractitioners = gpService.getAllGeneralPractitioners();

            if (patient == null) {
                // Patient not found, redirect back to patients list
                response.sendRedirect(request.getContextPath() + "/nurse/patients?error=patient_not_found");
                return;
            }

            // Set variables as request attributes

            request.setAttribute("generalPractitioners", GeneralPractitioners);
            request.setAttribute("patient", patient);

            // Forward to JSP
            request.getRequestDispatcher("/nurse/patient-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Invalid patient ID format
            response.sendRedirect(request.getContextPath() + "/nurse/patients?error=invalid_patient_id");
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
