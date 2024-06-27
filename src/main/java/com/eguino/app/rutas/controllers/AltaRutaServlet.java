package com.eguino.app.rutas.controllers;

import com.eguino.app.rutas.services.IRutasService;
import com.eguino.app.rutas.services.RutasService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet ("/rutas/alta")
public class AltaRutaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = (Connection) req.getAttribute("conn");
        IRutasService service = new RutasService(conn);
        req.setAttribute("camiones",service.listarCamiones());
        req.setAttribute("choferes",service.listarChoferes());
        getServletContext().getRequestDispatcher("/altaRutas.jsp")
                .forward(req, resp);
    }
}
