package com.example.med_consulting.Service;

import com.example.med_consulting.Model.GeneralPractitioner;
import com.example.med_consulting.Repository.GpRepository;

import java.util.ArrayList;
import java.util.List;

public class GpService {
    public List<GeneralPractitioner> getAllGeneralPractitioners() {
        GpRepository gpRepository = new GpRepository();
        return gpRepository.getGeneralPractitioners();
    }
}
