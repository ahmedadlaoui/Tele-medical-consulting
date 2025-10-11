package com.example.med_consulting.Util;

import com.example.med_consulting.Model.Enum.UserRole;
import com.example.med_consulting.Model.User;
import jakarta.servlet.http.HttpServletRequest;

import java.util.logging.Logger;

public class UserMapper {
    private static final Logger LOGGER = Logger.getLogger(UserMapper.class.getName());
    private final HttpServletRequest request;

    public UserMapper(HttpServletRequest request) {
        this.request = request;
    }

    public User buildUserFromRequest() {
        try {
            User builtUser = new User();
            builtUser.setFirstName(request.getParameter("firstName"));
            builtUser.setLastName(request.getParameter("lastName"));
            builtUser.setRole(UserRole.valueOf(request.getParameter("role").toUpperCase()));
            builtUser.setEmail(request.getParameter("email"));
            builtUser.setPhoneNumber(request.getParameter("phoneNumber"));
            builtUser.setPassword(PasswordUtil.hashPassword(request.getParameter("password")));
            builtUser.setLicenseNumber(request.getParameter("licenseNumber"));
            return builtUser;
        } catch (Exception e) {
            LOGGER.severe("error building User from request : " + e.getMessage());
            return null;
        }
    }
}
