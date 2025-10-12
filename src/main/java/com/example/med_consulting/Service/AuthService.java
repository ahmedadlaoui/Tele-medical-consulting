package com.example.med_consulting.Service;

import com.example.med_consulting.DAO.UserDAO;
import com.example.med_consulting.Model.GeneralPractitioner;
import com.example.med_consulting.Model.Nurse;
import com.example.med_consulting.Model.Specialist;
import com.example.med_consulting.Model.User;
import com.example.med_consulting.Repository.UserRepository;
import com.example.med_consulting.Util.PasswordUtil;

public class AuthService {

    public boolean registerUser(User user) {
        if (user == null || user.getRole() == null) {
            return false;
        }

        User userToInsert = switch (user.getRole()) {
            case NURSE -> {
                Nurse nurse = new Nurse();
                copyProperties(user, nurse);
                yield nurse;
            }
            case SPECIALIST -> {
                Specialist specialist = new Specialist();
                copyProperties(user, specialist);
                yield specialist;
            }
            case GENERAL_PRACTITIONER -> {
                GeneralPractitioner gp = new GeneralPractitioner();
                copyProperties(user, gp);
                yield gp;
            }
        };

        UserDAO userDAO = new UserDAO();
        return userDAO.insertUser(userToInsert);
    }

    public User loginUser(String email, String password) {
        UserRepository userRepository = new UserRepository();
        User searchedForUser = userRepository.getUserByEmail(email);
        if (searchedForUser != null && PasswordUtil.verifyPassword(password, searchedForUser.getPassword())) {
            return searchedForUser;
        }
        return null;
    }

    private void copyProperties(User source, User target) {
        target.setFirstName(source.getFirstName());
        target.setLastName(source.getLastName());
        target.setEmail(source.getEmail());
        target.setPassword(source.getPassword());
        target.setPhoneNumber(source.getPhoneNumber());
        target.setLicenseNumber(source.getLicenseNumber());
        target.setRole(source.getRole());
    }
}
