package com.example.med_consulting.Util;

import com.example.med_consulting.Model.Enum.UserRole;

public class RoleRedirect {

    public static String getRedirectUrl(UserRole role) {
        return switch (role) {
            case GENERAL_PRACTITIONER -> "/gp/dashboard.jsp";
            case SPECIALIST -> "/specialist/dashboard.jsp";
            case NURSE -> "/nurse/dashboard.jsp";
        };
    }
}
