package com.example.med_consulting.Repository.Interfaces;

import com.example.med_consulting.Model.User;

public interface UserRepositoryInterface {
    public User getUserByEmail(String email);

}
