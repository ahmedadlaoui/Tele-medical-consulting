package com.example.med_consulting.Controller;

import com.example.med_consulting.Model.TimeSlot;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");

        TimeSlotMapper timeSlotMapper = new TimeSlotMapper();
        TimeSlot timeSlot = timeSlotMapper.buildTimeSlotObject(request,email);



    }
}
