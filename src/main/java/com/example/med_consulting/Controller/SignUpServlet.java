package com.example.med_consulting.Controller;

import com.example.med_consulting.Model.User;
import com.example.med_consulting.Service.AuthService;
import com.example.med_consulting.Util.UserMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserMapper userMapper = new UserMapper(request);
        User newUser = userMapper.buildUserFromRequest();

        if (newUser == null) {
            request.getSession().setAttribute("flashMessage", "Invalid input, please check your data!");
            response.sendRedirect(request.getContextPath() + "/signup");
            return;
        }

        AuthService authService = new AuthService();
        boolean success = authService.registerUser(newUser);

        if (success) {
            request.getSession().setAttribute("flashMessage", "Your account has been successfully created!");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.getSession().setAttribute("flashMessage", "Registration failed. Please try again.");
            response.sendRedirect(request.getContextPath() + "/signup");
        }
    }
}
