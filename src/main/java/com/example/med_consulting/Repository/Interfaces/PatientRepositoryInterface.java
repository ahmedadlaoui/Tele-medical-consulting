package com.example.med_consulting.Repository.Interfaces;

import com.example.med_consulting.Model.Patient;


import java.util.List;

public interface PatientRepositoryInterface {
    public List<Patient> getPatientsByNurse(long nurse_id);
}
