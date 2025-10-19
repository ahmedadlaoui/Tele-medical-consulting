package com.example.med_consulting.Controller;

import com.example.med_consulting.Model.Enum.UserRole;
import com.example.med_consulting.Model.TimeSlot;
import com.example.med_consulting.Service.TimeSlotService;
import com.example.med_consulting.Util.TimeSlotMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/gp/dashboard")
public class GpDashboardServlet extends HttpServlet {
    public static void RouteProtection(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserRole role = (UserRole) session.getAttribute("userRole");
        if (role == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String jspPath;
        switch (role) {
            case NURSE:
                jspPath = "/nurse/dashboard.jsp";
                break;
            case GENERAL_PRACTITIONER:
                jspPath = "/gp/dashboard.jsp";
                break;
            case SPECIALIST:
                jspPath = "/specialist/dashboard.jsp";
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/login");
                return;
        }
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RouteProtection(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("userEmail");

        TimeSlotMapper timeSlotMapper = new TimeSlotMapper();
        TimeSlot timeSlot = timeSlotMapper.buildTimeSlotObject(request, email);

        TimeSlotService timeSlotService = new TimeSlotService();
        if (timeSlotService.addTimeSlot(timeSlot)) {
            session.setAttribute("flashMessage", "TimeSlot added successfully");
        } else {
            session.setAttribute("flashMessage", "TimeSlot adding failed");
        }
        response.sendRedirect(request.getContextPath() + "/gp/dashboard");
    }
}
