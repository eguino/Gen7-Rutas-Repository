package com.eguino.app.rutas.controllers;

import com.eguino.app.rutas.models.Camion;
import com.eguino.app.rutas.models.Chofer;
import com.eguino.app.rutas.models.Ruta;
import com.eguino.app.rutas.services.CamionesService;
import com.eguino.app.rutas.services.ChoferesService;
import com.eguino.app.rutas.services.IService;
import com.eguino.app.rutas.services.RutasService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

@WebServlet ("/rutas/listar")
public class ListaRutasServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = (Connection) req.getAttribute("conn");

        IService<Ruta> rutasService = new RutasService(conn);

        IService<Chofer> choferService = new ChoferesService(conn);
        IService<Camion> camionService = new CamionesService(conn);

        List<Ruta> rutas = rutasService.listar();

        List<Chofer> choferes = new ArrayList<>();
        List<Camion> camiones = new ArrayList<>();

        for (Ruta r : rutas){
            choferes.add(choferService.getById(r.getChoferId()).get());
            camiones.add(camionService.getById(r.getCamionId()).get());
        }


        req.setAttribute("rutas",rutas);
        req.setAttribute("choferes",choferes);
        req.setAttribute("camiones",camiones);
        getServletContext().getRequestDispatcher("/listaRutas.jsp").forward(req,resp);
    }
}
