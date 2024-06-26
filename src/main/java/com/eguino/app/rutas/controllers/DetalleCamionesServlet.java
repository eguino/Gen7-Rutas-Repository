package com.eguino.app.rutas.controllers;

import com.eguino.app.rutas.models.Camion;
import com.eguino.app.rutas.services.CamionesService;
import com.eguino.app.rutas.services.IService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.Optional;

@WebServlet("/camiones/detalle")
public class DetalleCamionesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = (Connection) req.getAttribute("conn");
        IService<Camion> service = new CamionesService(conn);
        long id;
        try {
            id = Long.parseLong(req.getParameter("id"));
        } catch (NumberFormatException e){
            id = 0L;
        }
        Camion camion = new Camion();
        if (id > 0){
            Optional<Camion> o = service.getById(id);
            if(o.isPresent()) {
                camion = o.get();
                req.setAttribute("camion",camion);
                getServletContext().getRequestDispatcher("/detalleCamion.jsp")
                        .forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                        "No existe el camión en la base de datos.");
            }
        }
        else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Error el id es null, se debe enviar como parámetro");
        }
    }
}
