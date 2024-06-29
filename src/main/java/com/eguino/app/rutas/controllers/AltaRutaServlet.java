package com.eguino.app.rutas.controllers;

import com.eguino.app.rutas.models.Cargamento;
import com.eguino.app.rutas.models.Ruta;
import com.eguino.app.rutas.services.CargamentoService;
import com.eguino.app.rutas.services.IRutasService;
import com.eguino.app.rutas.services.IService;
import com.eguino.app.rutas.services.RutasService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.Console;
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = (Connection) req.getAttribute("conn");
        IService<Ruta> rutaService = new RutasService(conn);
        IService<Cargamento> cargamentoService = new CargamentoService(conn);


        String chofer = req.getParameter("chofer");
        String camion = req.getParameter("camion");
        String origen = req.getParameter("origen");
        String destino = req.getParameter("destino");
        String fSalida = req.getParameter("FSalida");
        String fELlegada = req.getParameter("FELlegada");
        String distancia = req.getParameter("distancia");

        try{
            Float.parseFloat(distancia);
        } catch (NumberFormatException e){

        }

        System.out.println(distancia);
    }
}
