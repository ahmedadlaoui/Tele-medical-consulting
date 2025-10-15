package com.example.med_consulting.Repository;

import com.example.med_consulting.DAO.UserDAO;
import com.example.med_consulting.Model.User;
import com.example.med_consulting.Repository.Interfaces.UserRepositoryInterface;
import com.example.med_consulting.Util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class UserRepository implements UserRepositoryInterface {
    EntityManager em = JPAUtil.getInstance().getEntityManager();
    EntityTransaction transaction = em.getTransaction();

    public User getUserByEmail(String email) {
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (Exception e) {
            System.out.println("User not found" + e);
            return null;
        } finally {
            if (em.isOpen()) {
                em.close();
            }
        }

    }
}
