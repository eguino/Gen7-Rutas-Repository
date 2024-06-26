package com.eguino.app.rutas.controllers;

import com.eguino.app.rutas.models.Camion;
import com.eguino.app.rutas.models.enums.Marcas;
import com.eguino.app.rutas.models.enums.Tipos;
import com.eguino.app.rutas.services.CamionesService;
import com.eguino.app.rutas.services.IService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.*;

@WebServlet("/camiones/editar")
public class EdicionCamionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = (Connection) req.getAttribute("conn");
        IService<Camion> service = new CamionesService(conn);
        String matricula = req.getParameter("matricula");
        String tipoCamion = req.getParameter("tipoCamion");
        String modelo = req.getParameter("modelo");
        String marca = req.getParameter("marca");
        String capacidad = req.getParameter("capacidad");
        String kilometraje = req.getParameter("kilometraje");

        String checkbox[];
        checkbox = req.getParameterValues("disponibilidad");
        Boolean habilitar;
        if(checkbox != null){
            habilitar = true;
        } else {
            habilitar = false;
        }
        Map<String, String> errores = new HashMap<>();
        if (matricula == null || matricula.isBlank()) {
            errores.put("matricula", "¡La matricula es requerida!");
        }
        if (tipoCamion == null || tipoCamion.isBlank()){
            errores.put("tipoCamion","¡El tipo de camión paterno es requerido!");
        }
        if (modelo == null || modelo.isBlank()){
            errores.put("modelo","¡El modelo materno es requerido!");
        }
        if (marca == null || marca.isBlank()){
            errores.put("marca","¡La marca es requerida!");
        }
        if (capacidad == null || capacidad.isBlank()){
            errores.put("capacidad","¡La capacidad es requerida!");
        }
        if (kilometraje == null || kilometraje.isBlank()){
            errores.put("kilometraje","¡El kilometraje de nacimiento es requerido!");
        }

        long id;
        id = Long.parseLong(req.getParameter("id"));
        Camion camion = new Camion();
        camion.setId(id);
        camion.setMatricula(matricula);
        camion.setTipoCamion(Tipos.valueOf(tipoCamion.toUpperCase()));
        camion.setModelo(Integer.parseInt(modelo));
        camion.setMarca(Marcas.valueOf(marca.toUpperCase()));
        camion.setCapacidad(Integer.parseInt(capacidad));
        camion.setKilometraje(Double.parseDouble(kilometraje));
        camion.setDisponibilidad(habilitar);
        service.guardar(camion);

        if (errores.isEmpty()){

            service.guardar(camion);
            resp.sendRedirect("listar");
        } else {
            req.setAttribute("errores",errores);
            getServletContext().getRequestDispatcher("/edicionCamion.jsp")
                    .forward(req,resp);
        }
    }

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
                Calendar cal= Calendar.getInstance();
                int year= cal.get(Calendar.YEAR);

                int minimo= year-20;
                int maximo= year+1;

                req.setAttribute("maximo", maximo);
                req.setAttribute("minimo", minimo);
                req.setAttribute("tiposCamion", Arrays.asList(Tipos.values()));
                req.setAttribute("marcasCamion", Arrays.asList(Marcas.values()));
                camion = o.get();
                req.setAttribute("camion",camion);
                getServletContext().getRequestDispatcher("/edicionCamion.jsp")
                        .forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                        "No existe el camion en la base de datos.");
            }
        }
        else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Error el id es null, se debe enviar como parámetro");
        }
    }
}
