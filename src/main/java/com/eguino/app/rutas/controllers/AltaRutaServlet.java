package com.eguino.app.rutas.controllers;

import com.eguino.app.rutas.models.Cargamento;
import com.eguino.app.rutas.models.Ruta;
import com.eguino.app.rutas.services.CargamentoService;
import com.eguino.app.rutas.services.IRutasService;
import com.eguino.app.rutas.services.IService;
import com.eguino.app.rutas.services.RutasService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.Console;
import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
        IRutasService rutaService = new RutasService(conn);
        IService<Cargamento> cargamentoService = new CargamentoService(conn);


        String chofer = req.getParameter("chofer");
        String camion = req.getParameter("camion");
        String origen = req.getParameter("idOrigen");
        String destino = req.getParameter("idDestino");
        String fSalida = req.getParameter("FSalida");
        String fELlegada = req.getParameter("FELlegada");
        String distancia = req.getParameter("distancia");

        float distanciaF = convertirAFloat(distancia);

        LocalDate fechaSal;
        LocalDate fechaELleg;
        try{
            fechaSal = LocalDate.parse(fSalida,
                    DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        } catch (DateTimeParseException e){
            fechaSal = null;
        }

        try{
            fechaELleg = LocalDate.parse(fELlegada,
                    DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        } catch (DateTimeParseException e){
            fechaELleg = null;
        }

        Ruta ruta = new Ruta();
        ruta.setId(0L);
        ruta.setChoferId(Long.parseLong(chofer));
        ruta.setCamionId(Long.parseLong(camion));
        ruta.setDireccionOrigenId(Long.parseLong(origen));
        ruta.setDireccionDestinoId(Long.parseLong(destino));
        ruta.setFechaSalida(fechaSal);
        ruta.setFechaLlegadaEstimada(fechaELleg);
        ruta.setDistancia(distanciaF);

        Long idRuta = rutaService.guardarReturnId(ruta);

        System.out.println(ruta);

        String cargamentosJson = req.getParameter("cargamentos");
        System.out.println("Cargamentos JSON: " + cargamentosJson);
        List<Map<String, String>> cargamentos = new Gson().fromJson(cargamentosJson, ArrayList.class);

        // Aquí puedes guardar los datos de cargamento en tu base de datos
        for (Map<String, String> cargamento : cargamentos) {
            String descripcion = cargamento.get("descripcion");
            String peso = cargamento.get("peso");

            System.out.println(descripcion);
            System.out.println(peso);

            Cargamento c = new Cargamento();
            c.setRuta_id(idRuta);
            c.setDescripcion(descripcion);
            c.setPeso(Float.parseFloat(peso));
            c.setEstatus(1);
            cargamentoService.guardar(c);
        }

        resp.sendRedirect("listar");
    }

    public static float convertirAFloat(String texto) {
        // Eliminar espacios en blanco al inicio y al final del texto
        texto = texto.trim();

        // Reemplazar comas por puntos en caso de que la coma sea un separador decimal
        texto = texto.replace(",", "");

        // Separar la parte numérica de la unidad
        String[] partes = texto.split(" ");
        if (partes.length != 2) {
            throw new IllegalArgumentException("El formato del texto es incorrecto. Debe ser 'valor unidad'.");
        }

        // Extraer el valor y la unidad
        float valor = Float.parseFloat(partes[0]);
        String unidad = partes[1].toLowerCase();

        // Convertir el valor dependiendo de la unidad
        switch (unidad) {
            case "m":
                return valor * 0.001f; // metros a kilómetros
            case "km":
                return valor; // kilómetros a kilómetros (ya está en la unidad correcta)
            default:
                throw new IllegalArgumentException("Unidad no soportada. Usa 'm', 'km', 'cm', 'mm', 'ft', 'yd', 'mi'.");
        }
    }

}
