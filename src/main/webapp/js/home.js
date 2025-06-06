// home.js

// Función para cargar el mensaje de bienvenida (se usa en dashboard.jsp)
function loadWelcomeMessage() {
    const usuario = localStorage.getItem('usuario');
    const perfil = localStorage.getItem('perfil');

    if (usuario && perfil) {
        const welcomeMessage = `¡Hola, ${usuario}! Has iniciado sesión como ${perfil}.`;
        document.getElementById('welcomeMessage').textContent = welcomeMessage;

        const profileName = `${perfil}`;
        document.getElementById('nombrePerfil').textContent = profileName;
    } else {
        // Si no hay datos en localStorage, redirigir al login
        window.location.href = 'login.jsp'; // en Maven, la vista se llama login.jsp
    }
}

// Función para cerrar sesión
function logout() {
    localStorage.removeItem('usuario');
    localStorage.removeItem('perfil');
    window.location.href = 'login.jsp';
}

// Asignar eventos al cargar la página
document.addEventListener('DOMContentLoaded', () => {
    loadWelcomeMessage();
    const logoutButton = document.getElementById('logoutButton');
    if (logoutButton) {
        logoutButton.addEventListener('click', logout);
    }
});


