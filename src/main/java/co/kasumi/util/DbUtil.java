package co.kasumi.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbUtil {

    // 1) URL de conexión a la base de datos KasumiDB en localhost:3306
    private static final String JDBC_URL =
        "jdbc:mysql://localhost:3306/KasumiDB?useSSL=false&serverTimezone=UTC";

    // 2) Usuario y contraseña de MySQL
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "1234567";

    // 3) Cargar el driver (opcional con Connector/J 8.x+ pero lo dejamos)
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Error cargando el driver de MySQL: " + e.getMessage());
        }
    }

    /**
     * Retorna una conexión a la base de datos KasumiDB
     * @return Connection
     * @throws SQLException si falla la conexión
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }
}
