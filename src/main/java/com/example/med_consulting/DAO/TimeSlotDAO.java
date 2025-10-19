package com.example.med_consulting.DAO;

import com.example.med_consulting.DAO.Interfaces.TimeSlotDAOInterface;
import com.example.med_consulting.Model.TimeSlot;
import com.example.med_consulting.Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class TimeSlotDAO implements TimeSlotDAOInterface {

    @Override
    public boolean insertTimeSlot(TimeSlot timeSlot) {
        EntityManager em = JPAUtil.getInstance().getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(timeSlot);
            tx.commit();
            System.out.println(timeSlot);
            return true;
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            System.out.println("Error inserting timeslot in database: " + e.getMessage());
            return false;
        } finally {
            if (em.isOpen()) {
                em.close();
                System.out.println("EntityManager closed");
            }
        }
    }
}
