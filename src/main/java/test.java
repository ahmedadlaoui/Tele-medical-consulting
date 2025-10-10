    import jakarta.persistence.EntityManagerFactory;
    import jakarta.persistence.Persistence;

    public class test {
        public static void main(String[] args) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");
                System.out.println("✅ JPA connected to database!");
                emf.close();
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("❌ Failed to connect to the database.");
            }
        }
    }
