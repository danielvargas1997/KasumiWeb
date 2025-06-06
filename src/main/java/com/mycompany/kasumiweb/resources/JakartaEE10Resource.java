package com.mycompany.kasumiweb.resources;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

/**
 * Recurso de prueba para Jakarta EE 10 (JAX-RS).
 */
@Path("jakartaee10")
public class JakartaEE10Resource {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Response ping() {
        return Response
                .ok("ping Jakarta EE")
                .build();
    }
}

