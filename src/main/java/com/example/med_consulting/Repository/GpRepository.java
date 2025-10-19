package com.example.med_consulting.Repository;

import com.example.med_consulting.Model.GeneralPractitioner;
import com.example.med_consulting.Repository.Interfaces.GpRepositoryInterface;
import com.example.med_consulting.Util.JPAUtil;
import jakarta.persistence.EntityManager;

import java.util.ArrayList;
import java.util.List;

public class GpRepository implements GpRepositoryInterface {
    public List<GeneralPractitioner> getGeneralPractitioners() {
        List<GeneralPractitioner> generalPractitioners = null;
        EntityManager em = null;
        try {
            em = JPAUtil.getInstance().getEntityManager();
            generalPractitioners = em.createQuery("select g from GeneralPractitioner g ", GeneralPractitioner.class)
                    .getResultList();

            System.out.println("List of general practitioners : " + generalPractitioners);
            return generalPractitioners;
        } catch (Exception e) {
            System.out.println("ERROR: Failed to fetch General Practitioners - " + e.getMessage());
            return generalPractitioners;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
