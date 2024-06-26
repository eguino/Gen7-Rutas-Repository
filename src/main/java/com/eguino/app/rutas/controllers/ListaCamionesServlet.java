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
import java.util.List;

@WebServlet("/camiones/listar")
public class ListaCamionesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Recuperamos la conexion que provee el filtro
        Connection conn = (Connection) req.getAttribute("conn");

        //resp.getWriter().println("<h1>Camiones</h1>");
        //resp.getWriter().println("<p>Lista con todos los camiones registrados en la empresa</p>");
        //Declaramos un objeto de tipo servicio
        IService<Camion> service = new CamionesService(conn);
        List<Camion> camiones = service.listar();

        req.setAttribute("camiones",camiones);
        getServletContext().getRequestDispatcher("/listaCamiones.jsp").forward(req,resp);
    }
}
