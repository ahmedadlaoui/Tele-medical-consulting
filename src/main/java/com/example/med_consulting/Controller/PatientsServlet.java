package com.example.med_consulting.Controller;

import com.example.med_consulting.Model.Enum.UserRole;
import com.example.med_consulting.Model.Patient;
import com.example.med_consulting.Service.PatientService;
import com.example.med_consulting.Util.PatientMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@WebServlet("/nurse/patients")
@MultipartConfig(maxFileSize = 1024 * 1024 * 2, // 2 MB
        maxRequestSize = 1024 * 1024 * 10, // 10 MB
        fileSizeThreshold = 1024 * 1024 // 1 MB
)
public class PatientsServlet extends HttpServlet {

    private final PatientService patientService = new PatientService();

    // Upload directory path - relative to webapp
    private static final String UPLOAD_DIRECTORY = "uploads/patients";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isValidNurseSession(request, response)) {
            return;
        }

        Long userId = (Long) request.getSession().getAttribute("userId");

        // Get search parameter
        String searchQuery = request.getParameter("search");
        boolean isSearch = searchQuery != null && !searchQuery.trim().isEmpty();

        // Get page parameter from URL (default to 1)
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        List<Patient> patients;
        int totalPages;
        long totalPatients;

        if (isSearch) {
            // Search mode
            patients = patientService.searchPatientsByNursePaginated(userId, searchQuery.trim(), currentPage);
            totalPatients = patientService.countSearchResults(userId, searchQuery.trim());
            totalPages = (int) Math.ceil((double) totalPatients / 12);
        } else {
            // Normal mode - all patients
            patients = patientService.getPatientsByNursePaginated(userId, currentPage);
            totalPatients = patientService.countPatientsByNurse(userId);
            totalPages = patientService.getTotalPages(userId);
        }

        // If current page exceeds total pages, redirect to last valid page
        if (currentPage > totalPages && totalPages > 0) {
            String redirectUrl = request.getContextPath() + "/nurse/patients?page=" + totalPages;
            if (isSearch) {
                redirectUrl += "&search=" + searchQuery;
            }
            response.sendRedirect(redirectUrl);
            return;
        }

        // Set attributes for JSP
        request.setAttribute("patients", patients);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalPatients", totalPatients);

        request.getRequestDispatcher("/nurse/patients.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== Patient Registration POST Request ===");

        if (!isValidNurseSession(request, response)) {
            System.out.println("ERROR: Invalid nurse session");
            return;
        }

        Long userId = (Long) request.getSession().getAttribute("userId");
        System.out.println("Nurse User ID: " + userId);

        try {
            // Handle profile picture upload (OPTIONAL)
            String profilePicturePath = handleFileUpload(request);
            if (profilePicturePath != null) {
                System.out.println("Profile picture uploaded: " + profilePicturePath);
            } else {
                System.out.println("No profile picture uploaded (optional)");
            }

            // Build patient from request
            PatientMapper patientMapper = new PatientMapper(request);
            Patient patient = patientMapper.buildPatientFromRequest();

            if (patient == null) {
                System.out.println("ERROR: Patient mapper returned null - invalid input");
                response.sendRedirect(request.getContextPath() + "/nurse/patients?error=invalid_input");
                return;
            }

            // Set the profile picture path (can be null)
            patient.setProfilePicture(profilePicturePath);

            System.out.println("Patient object created successfully, attempting to register...");
            boolean success = patientService.registerPatient(patient, userId);

            if (success) {
                System.out.println("SUCCESS: Patient registered successfully");
                request.getSession().setAttribute("successMessage", "Patient registered successfully!");
                response.sendRedirect(request.getContextPath() + "/nurse/patients");
            } else {
                System.out.println("ERROR: Registration failed in service layer");
                request.getSession().setAttribute("errorMessage", "Failed to register patient. Please try again.");
                response.sendRedirect(request.getContextPath() + "/nurse/patients");
            }

        } catch (Exception e) {
            System.out.println("ERROR: Patient registration exception - " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "System error occurred. Please contact administrator.");
            response.sendRedirect(request.getContextPath() + "/nurse/patients");
        }
    }

    /**
     * Handle file upload - SIMPLE approach
     * Saves file to webapp/uploads/patients folder
     * Returns the relative path to store in database (or null if no file)
     */
    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
        try {
            // Get the file part from request
            Part filePart = request.getPart("profilePicture");

            // If no file uploaded or empty, return null (OPTIONAL field)
            if (filePart == null || filePart.getSize() == 0) {
                return null;
            }

            String fileName = getFileName(filePart);
            if (fileName == null || fileName.isEmpty()) {
                return null;
            }

            // Generate unique filename to avoid conflicts
            String fileExtension = "";
            int dotIndex = fileName.lastIndexOf('.');
            if (dotIndex > 0) {
                fileExtension = fileName.substring(dotIndex);
            }
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Get the real path to webapp/uploads/patients
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;

            // Create directory if it doesn't exist
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
                System.out.println("Created upload directory: " + uploadPath);
            }

            // Full file path
            Path filePath = Paths.get(uploadPath, uniqueFileName);

            // Save the file
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            // Return the relative path to store in database (for accessing via URL)
            String relativePath = "/" + UPLOAD_DIRECTORY + "/" + uniqueFileName;
            System.out.println("File saved successfully: " + relativePath);

            return relativePath;

        } catch (Exception e) {
            System.out.println("ERROR: File upload failed - " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Extract filename from Part header
     */
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    /**
     * Validates that the user has a valid session and NURSE role.
     * If validation fails, redirects to login page.
     */
    private boolean isValidNurseSession(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        UserRole role = (UserRole) session.getAttribute("userRole");

        if (role != UserRole.NURSE) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        return true;
    }

}