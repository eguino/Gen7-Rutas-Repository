package com.eguino.app.rutas.controllers;

import com.eguino.app.rutas.models.Chofer;
import com.eguino.app.rutas.services.ChoferesService;
import com.eguino.app.rutas.services.IService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet ("/choferes/eliminar")
public class EliminarChoferServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = (Connection) req.getAttribute("conn");
        IService<Chofer> service = new ChoferesService(conn);
        long id;
        try {
            id = Long.parseLong(req.getParameter("id"));
        } catch (NumberFormatException e){
            id = 0L;
        }
        Chofer chofer = new Chofer();
        if (id > 0){
            Optional<Chofer> o = service.getById(id);
            if(o.isPresent()) {
                try {
                    service.eliminar(id);
                    resp.sendRedirect(req.getContextPath() + "/choferes/listar");
                } catch (Exception e) {
                    req.setAttribute("message", e.getMessage());
                    req.setAttribute("path", req.getContextPath() + "/choferes/listar");
                    req.getRequestDispatcher("/resultado.jsp").forward(req, resp);
                }
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                        "No existe el chofer en la base de datos.");
            }
        }
        else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Error el id es null, se debe enviar como parámetro");
        }
    }
}
