package com.mycompany.kasumiweb;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;

/**
 * (Opcionalmente) Anotación para definir la ruta base de los servicios REST.
 * Si ya tienes el servlet mapeado en web.xml, no es obligatorio, pero no causa errores.
 */
@ApplicationPath("resources")
public class JakartaRestConfiguration extends Application {
    // Clase vacía; Jersey la usará para detectar recursos en com.mycompany.kasumiweb.resources
}

