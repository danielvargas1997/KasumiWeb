# Proyecto Kasumi

Aplicación Java de escritorio con sistema de autenticación, redireccionamiento al módulo de gestión de clientes y operaciones CRUD. Utiliza JDBC para la conexión con base de datos MySQL. Proyecto académico desarrollado en el marco del programa Tecnólogo en Análisis y Desarrollo de Software (Ficha Técnica 2977435) del SENA.

---

## 🛠️ Tecnologías utilizadas

* **Java SE (Java 11+)**
* **JDBC Driver (Connector/J 8.x)**
* **NetBeans IDE**
* **MySQL**
* **Swing** para la interfaz gráfica
* **Programación Orientada a Objetos** (paquetes, clases, métodos, variables)

---

## 🚀 Cómo ejecutar el proyecto

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/TuUsuario/KasumiJavaDesktop.git
   ```

   (Reemplaza `TuUsuario` por tu usuario de GitHub.)

2. **Importar el proyecto en NetBeans:**

   1. Abrir NetBeans.
   2. Seleccionar **File → Open Project**.
   3. Navegar hasta la carpeta del proyecto clonado y hacer clic en **Open Project**.

3. **Configurar la base de datos MySQL:**

   1. Abrir MySQL Workbench o tu cliente preferido.
   2. Crear la base de datos:

      ```sql
      CREATE DATABASE KasumiDB
      CHARACTER SET utf8mb4
      COLLATE utf8mb4_unicode_ci;
      USE KasumiDB;
      ```
   3. Ejecutar el script SQL proporcionado (`scripts/kasumi_schema.sql`) para crear tablas y datos de prueba:

      ```sql
      -- roles
      CREATE TABLE Rol (
        idRol INT AUTO_INCREMENT PRIMARY KEY,
        nombreRol VARCHAR(50) NOT NULL
      ) ENGINE=InnoDB;
      INSERT INTO Rol (nombreRol) VALUES ('Administrador'), ('Recepcionista'), ('Contador');

      -- permisos (si aplica)
      CREATE TABLE Permiso (
        idPermiso INT AUTO_INCREMENT PRIMARY KEY,
        nombrePermiso VARCHAR(50) NOT NULL
      ) ENGINE=InnoDB;

      CREATE TABLE Rol_Permiso (
        idRol INT NOT NULL,
        idPermiso INT NOT NULL,
        PRIMARY KEY (idRol, idPermiso),
        FOREIGN KEY (idRol) REFERENCES Rol(idRol) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (idPermiso) REFERENCES Permiso(idPermiso) ON DELETE CASCADE ON UPDATE CASCADE
      ) ENGINE=InnoDB;

      -- usuarios
      CREATE TABLE Usuario (
        idUsuario INT AUTO_INCREMENT PRIMARY KEY,
        nombreUsuario VARCHAR(50) NOT NULL UNIQUE,
        contrasena VARCHAR(255) NOT NULL,
        idRol INT NOT NULL,
        FOREIGN KEY (idRol) REFERENCES Rol(idRol) ON DELETE RESTRICT ON UPDATE CASCADE
      ) ENGINE=InnoDB;
      INSERT INTO Usuario (nombreUsuario, contrasena, idRol) VALUES
        ('admin', 'admin123', 1),
        ('recep1', 'recep123', 2),
        ('conta1', 'conta123', 3);

      -- clientes
      CREATE TABLE Cliente (
        idCliente INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        apellido VARCHAR(100) NOT NULL,
        telefono VARCHAR(20),
        email VARCHAR(100),
        fechaNacimiento DATE
      ) ENGINE=InnoDB;

      -- especialistas
      CREATE TABLE Especialista (
        idEspecialista INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        especialidad VARCHAR(100) NOT NULL
      ) ENGINE=InnoDB;

      -- servicios
      CREATE TABLE Servicio (
        idServicio INT AUTO_INCREMENT PRIMARY KEY,
        nombreServicio VARCHAR(100) NOT NULL,
        duracionMin INT NOT NULL,
        precio DECIMAL(10,2) NOT NULL
      ) ENGINE=InnoDB;

      -- citas
      CREATE TABLE Cita (
        idCita INT AUTO_INCREMENT PRIMARY KEY,
        fechaHora DATETIME NOT NULL,
        idCliente INT NOT NULL,
        idEspecialista INT NOT NULL,
        FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (idEspecialista) REFERENCES Especialista(idEspecialista) ON DELETE CASCADE ON UPDATE CASCADE
      ) ENGINE=InnoDB;

      CREATE TABLE Cita_Servicio (
        idCita INT NOT NULL,
        idServicio INT NOT NULL,
        PRIMARY KEY (idCita, idServicio),
        FOREIGN KEY (idCita) REFERENCES Cita(idCita) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (idServicio) REFERENCES Servicio(idServicio) ON DELETE CASCADE ON UPDATE CASCADE
      ) ENGINE=InnoDB;
      ```

4. **Actualizar credenciales de conexión en el proyecto:**

   * Abre la clase `co.kasumi.util.DbUtil.java` y verifica que la URL, usuario y contraseña coincidan con tu configuración de MySQL. Ejemplo:

     ```java
     private static final String URL =
         "jdbc:mysql://localhost:3306/KasumiDB"
       + "?allowPublicKeyRetrieval=true"
       + "&useSSL=false"
       + "&serverTimezone=UTC";
     private static final String USER     = "root";
     private static final String PASSWORD = "1234567";
     ```

5. **Ejecutar la aplicación en NetBeans:**

   1. En el panel de proyectos, haz clic derecho sobre el proyecto **KasumiJavaDesktop**.
   2. Selecciona **Run** o presiona **F6**.
   3. Debería abrirse la ventana de login de la aplicación de escritorio.

---

## 🔐 Funcionalidades principales

1. **Inicio de sesión (login):**

   * Los usuarios se autentican con nombre de usuario, contraseña y tipo de rol (`Administrador`, `Recepcionista` o `Contador`).
   * Si las credenciales son válidas, se les redirige al menú principal.

2. **Redireccionamiento a módulo de Clientes:**

   * Una vez logueado como “Administrador” o “Recepcionista”, se habilita el acceso a la gestión de clientes.
   * El rol “Contador” no puede acceder al módulo de clientes.

3. **CRUD de Clientes (Swing + JDBC):**

   * **Listado de clientes:** muestra tabla con ID, Nombre, Apellido, Teléfono, Email y Fecha de Nacimiento.
   * **Crear cliente:** formulario para ingresar datos (nombre, apellido, teléfono, email, fecha de nacimiento).
   * **Actualizar cliente:** precarga los datos de un cliente seleccionado y guarda los cambios.
   * **Eliminar cliente:** confirma y borra el cliente de la base de datos.
   * **Buscar cliente:** filtra por nombre o apellido.

4. **Conexión JDBC:**

   * Todas las operaciones (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) se realizan con `PreparedStatement` para evitar inyecciones SQL.
   * La clase `DbUtil` maneja la creación de la conexión a MySQL.

5. **Interfaz gráfica con Swing:**

   * Formularios y ventanas desarrollados con `JFrame`, `JTable`, `JButton`, `JTextField`, `JPasswordField`, etc.
   * Validaciones básicas en campos (no permitir campos vacíos).

---

## 👥 Autores

Desarrollado por los aprendices del SENA (Ficha Técnica 2977435):

* **Daniel Alejandro Vargas Uzuriaga**
* **Daniela López Chica**
* **Jonathan Cardona Calderon**
* **Luz Eleidis Baldovino González**

---

## 📄 Licencia

Este proyecto académico está liberado para fines educativos. Cualquier reproducción o modificación debe citar a los autores originales y al SENA.

---

![Logo SENA](https://upload.wikimedia.org/wikipedia/commons/5/53/SENA_logo.svg)

> **Tecnólogo en Análisis y Desarrollo de Software**
> **Servicio Nacional de Aprendizaje (SENA)**
> Ficha Técnica **2977435**

---

**¡Gracias por revisar el Proyecto Kasumi!**
