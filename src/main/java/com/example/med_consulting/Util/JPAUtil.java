package com.example.med_consulting.Util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final String PERSISTENCE_UNIT = "default";
    private static JPAUtil instance;
    private final EntityManagerFactory entityManagerFactory;

    private JPAUtil() {
        try {
            this.entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
        } catch (Exception e) {
            System.err.println("❌ Database connection failed! error : " + e.getMessage());
            throw new ExceptionInInitializerError(e);
        }
    }

    public static JPAUtil getInstance() {
        if (instance == null) {
            synchronized (JPAUtil.class) {
                if (instance == null) {
                    instance = new JPAUtil();
                }
            }
        }
        return instance;
    }

    public EntityManager getEntityManager() {
        if (this.entityManagerFactory == null || !this.entityManagerFactory.isOpen()) {
            throw new IllegalStateException("EntityManagerFactory unavailable");
        }
        return this.entityManagerFactory.createEntityManager();
    }

    public EntityManagerFactory getEntityManagerFactory() {
        return this.entityManagerFactory;
    }

    public void close() {
        if (this.entityManagerFactory != null && this.entityManagerFactory.isOpen()) {
            this.entityManagerFactory.close();
            System.out.println("EntityManagerFactory closed");
        }
    }

}
