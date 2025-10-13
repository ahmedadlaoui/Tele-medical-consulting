package com.example.med_consulting.Controller;

import com.example.med_consulting.Model.User;
import com.example.med_consulting.Service.AuthService;
import com.example.med_consulting.Util.RoleRedirect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Login attempt for email: " + email);

        AuthService authService = new AuthService();
        User user = authService.loginUser(email, password);

        if (user != null) {
            System.out.println("Login successful for: " + user.getEmail() + " with role: " + user.getRole());

            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userName", user.getFirstName() + " " + user.getLastName());

            System.out.println("Redirecting to: /dashboard");

            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            System.out.println("Login failed for email: " + email);

            HttpSession session = request.getSession();
            session.setAttribute("flashMessage", "Invalid email or password");
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
