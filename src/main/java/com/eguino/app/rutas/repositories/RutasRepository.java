package com.eguino.app.rutas.repositories;

import com.eguino.app.rutas.models.Ruta;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RutasRepository implements IRutasRepository {
    private Connection conn;

    public RutasRepository(Connection conn){
        this.conn = conn;
    }

    @Override
    public Long guardarReturnId(Ruta ruta) throws SQLException {
        System.out.println("Entré a ruta repository");
        String sql = "insert into rutas (ID_RUTA, CAMION_ID, CHOFER_ID, "
                + "DIRECCION_ORIGEN_ID, DIRECCION_DESTINO_ID, "
                + "DISTANCIA, FECHA_SALIDA, FECHA_LLEGADA_ESTIMADA) "
                + "VALUES (SEQUENCE4.NEXTVAL,?,?,?,?,?,?,?)";
        Long resultado = -1L;

        try (PreparedStatement stmt = conn.prepareStatement(sql, new String[]{"ID_RUTA"})) {
            stmt.setLong(1, ruta.getCamionId());
            stmt.setLong(2, ruta.getChoferId());
            stmt.setLong(3, ruta.getDireccionOrigenId());
            stmt.setLong(4, ruta.getDireccionDestinoId());
            stmt.setFloat(5, ruta.getDistancia());
            stmt.setDate(6, Date.valueOf(ruta.getFechaSalida()));
            stmt.setDate(7, Date.valueOf(ruta.getFechaLlegadaEstimada()));

            // Ejecutar la sentencia SQL
            int affectedRows = stmt.executeUpdate();

            // Asegurarse de que se ha insertado una fila
            if (affectedRows == 0) {
                throw new SQLException("La inserción de la ruta falló, no se insertaron filas.");
            }

            // Obtener las claves generadas
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    resultado = rs.getLong(1);
                } else {
                    throw new SQLException("La inserción de la ruta falló, no se obtuvo ningún ID.");
                }
            }
        }

        return resultado;
    }


    @Override
    public List<Ruta> listar() throws SQLException {
        List<Ruta> rutas = new ArrayList<>();
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM RUTAS")) {
            while (rs.next()){
                Ruta a = this.getRuta(rs);
                rutas.add(a);
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return rutas;
    }

    @Override
    public Ruta getById(Long id) throws SQLException {
        return null;
    }

    @Override
    public void guardar(Ruta ruta) throws SQLException {
        String sql = "";
        if (ruta.getId() != null && ruta.getId() > 0) {
            sql = "update rutas set camion_id=?, chofer_id=?, " +
                    "direccion_origen_id=?, direccion_destino_id=?, " +
                    "distancia=?, fecha_salida=?, fecha_llegada_estimada=? " +
                    "where id_ruta=?";
        } else {
            sql = "insert into rutas(id_ruta, camion_id, chofer_id, " +
                    "direccion_origen_id, direccion_destino_id, distancia, " +
                    "fecha_salida, fecha_llegada_estimada) " +
                    "values (SEQUENCE4.NEXTVAL,?,?,?,?,?,?,?)";
        }
        try (PreparedStatement stmt = conn.prepareStatement(sql)){
            if(ruta.getId() != null && ruta.getId() > 0){
                stmt.setLong(1,ruta.getCamionId());
                stmt.setLong(2,ruta.getChoferId());
                stmt.setLong(3,ruta.getDireccionOrigenId());
                stmt.setLong(4,ruta.getDireccionDestinoId());
                stmt.setFloat(5, ruta.getDistancia());
                stmt.setDate(6, Date
                        .valueOf(ruta.getFechaSalida()));
                stmt.setDate(7, Date
                        .valueOf(ruta.getFechaLlegadaEstimada()));
                stmt.setLong(8, ruta.getId());
            } else {
                stmt.setLong(1,ruta.getCamionId());
                stmt.setLong(2,ruta.getChoferId());
                stmt.setLong(3,ruta.getDireccionOrigenId());
                stmt.setLong(4,ruta.getDireccionDestinoId());
                stmt.setFloat(5, ruta.getDistancia());
                stmt.setDate(6, Date
                        .valueOf(ruta.getFechaSalida()));
                stmt.setDate(7, Date
                        .valueOf(ruta.getFechaLlegadaEstimada()));
            }
            stmt.executeUpdate();
        }
    }

    public Long guardarId(Ruta ruta) throws SQLException {
        Ruta a;
        try (Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT SEQUENCE4.NEXTVAL FROM DUAL;")) {
            a = this.getRuta(rs);
        } catch (SQLException e){
            throw new RuntimeException(e);
        }

        String sql = "";
        if (ruta.getId() != null && ruta.getId() > 0) {
            sql = "update rutas set camion_id=?, chofer_id=?, " +
                    "direccion_origen_id=?, direccion_destino_id=?, " +
                    "distancia=?, fecha_salida=?, fecha_llegada_estimada=? " +
                    "where id_ruta=?";
        } else {
            sql = "insert into rutas(id_ruta, camion_id, chofer_id, " +
                    "direccion_origen_id, direccion_destino_id, distancia, " +
                    "fecha_salida, fecha_llegada_estimada) " +
                    "values (?,?,?,?,?,?,?,?)";
        }
        try (PreparedStatement stmt = conn.prepareStatement(sql)){
            if(ruta.getId() != null && ruta.getId() > 0){
                stmt.setLong(1,ruta.getCamionId());
                stmt.setLong(2,ruta.getChoferId());
                stmt.setLong(3,ruta.getDireccionOrigenId());
                stmt.setLong(4,ruta.getDireccionDestinoId());
                stmt.setFloat(5, ruta.getDistancia());
                stmt.setDate(6, Date
                        .valueOf(ruta.getFechaSalida()));
                stmt.setDate(7, Date
                        .valueOf(ruta.getFechaLlegadaEstimada()));
                stmt.setLong(8, ruta.getId());
            } else {
                stmt.setLong(1,a.getId());
                stmt.setLong(2,ruta.getCamionId());
                stmt.setLong(3,ruta.getChoferId());
                stmt.setLong(4,ruta.getDireccionOrigenId());
                stmt.setLong(5,ruta.getDireccionDestinoId());
                stmt.setFloat(6, ruta.getDistancia());
                stmt.setDate(7, Date
                        .valueOf(ruta.getFechaSalida()));
                stmt.setDate(8, Date
                        .valueOf(ruta.getFechaLlegadaEstimada()));
            }
            stmt.executeUpdate();
        }

        return a.getId();
    }

    @Override
    public void eliminar(Long id) throws SQLException {

    }

    private Ruta getRuta(ResultSet rs) throws SQLException {
        Ruta a = new Ruta();
        a.setId(rs.getLong("ID_RUTA"));
        a.setCamionId(rs.getLong("CAMION_ID"));
        a.setChoferId(rs.getLong("CHOFER_ID"));
        a.setDireccionOrigenId(rs.getLong("DIRECCION_ORIGEN_ID"));
        a.setDireccionDestinoId(rs.getLong("DIRECCION_DESTINO_ID"));
        a.setDistancia(rs.getFloat("DISTANCIA"));
        a.setFechaSalida(rs.getDate("FECHA_SALIDA").toLocalDate());
        a.setFechaLlegadaEstimada(rs.getDate("FECHA_LLEGADA_ESTIMADA").toLocalDate());
        a.setaTiempo(rs.getInt("A_TIEMPO"));
        return a;
    }
}
