package com.eguino.app.rutas.controllers;

import com.eguino.app.rutas.models.Camion;
import com.eguino.app.rutas.services.CamionesService;
import com.eguino.app.rutas.services.IService;
import com.eguino.app.rutas.utils.ConexionBD;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.Optional;

@WebServlet("/capacidadCamion")
public class CapacidadCamionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = (Connection) request.getAttribute("conn");
        IService<Camion> service = new CamionesService(conn);

        String idCamion = request.getParameter("idCamion");

        // Lógica para obtener la capacidad del camión basado en idCamion
        Optional<Camion> camion = service.getById(Long.parseLong(idCamion));

        if(camion.isPresent()) {
            // Crear un objeto JSON para devolver la capacidad
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("capacidad", camion.get().getCapacidad());

            // Devolver los datos como JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse.toString());
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "No existe el camion en la base de datos.");
        }
    }
}
