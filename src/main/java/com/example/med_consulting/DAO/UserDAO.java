package com.example.med_consulting.DAO;

import com.example.med_consulting.DAO.Interfaces.UserDAOInterface;
import com.example.med_consulting.Model.User;
import com.example.med_consulting.Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class UserDAO implements UserDAOInterface {

    public boolean insertUser(User user) {
        EntityManager em = JPAUtil.getInstance().getEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.persist(user);
            transaction.commit();
            return true;

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
                System.err.println("Error: " + e.getMessage());
            }
            return false;
        } finally {
            if (em.isOpen()) {
                em.close();
                System.out.println("🔒 EntityManager closed");
            }
        }

    }
}
