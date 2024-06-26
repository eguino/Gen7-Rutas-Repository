package com.eguino.app.rutas.repositories;

import com.eguino.app.rutas.models.Camion;
import com.eguino.app.rutas.models.enums.Marcas;
import com.eguino.app.rutas.models.enums.Tipos;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CamionesRepository implements IRepository<Camion> {
    private Connection conn;

    public CamionesRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Camion> listar() throws SQLException {
        List<Camion> camiones = new ArrayList<>();
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM CAMIONES")) {
            while (rs.next()){
                Camion a = this.getCamion(rs);
                camiones.add(a);
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }
        return camiones;
    }

    @Override
    public Camion getById(Long id) throws SQLException {
        return null;
    }

    @Override
    public void guardar(Camion camion) throws SQLException {
        String sql = "";
        if (camion.getId() != null && camion.getId() > 0) {
            sql = "update camiones set matricula=?, tipo_camion=?, " +
                    "modelo=?, marca=?, capacidad=?, " +
                    "kilometraje=?, disponibilidad=? " +
                    "where id_camion=?";
        } else {
            sql = "insert into camiones(id_camion, matricula, " +
                    "tipo_camion, modelo, marca, capacidad, " +
                    "kilometraje, disponibilidad) " +
                    "values (SEQUENCE2.NEXTVAL,?,?,?,?,?,?,?)";
        }
        try (PreparedStatement stmt = conn.prepareStatement(sql)){
            if(camion.getId() != null && camion.getId() > 0){
                stmt.setString(1,camion.getMatricula());
                stmt.setString(2,camion.getTipoCamion().toString());
                stmt.setInt(3,camion.getModelo());
                stmt.setString(4,camion.getMarca().toString());
                stmt.setInt(5, camion.getCapacidad());
                stmt.setDouble(6, camion.getKilometraje());
                stmt.setInt(7, camion.getDisponibilidad() ? 1:0);
                stmt.setLong(8, camion.getId());
            } else {
                stmt.setString(1,camion.getMatricula());
                stmt.setString(2,camion.getTipoCamion().toString());
                stmt.setInt(3,camion.getModelo());
                stmt.setString(4,camion.getMarca().toString());
                stmt.setInt(5, camion.getCapacidad());
                stmt.setDouble(6,camion.getKilometraje());
                // Operador ternario
                stmt.setInt(7, camion.getDisponibilidad() ? 1:0);
            }
            stmt.executeUpdate();
        }
    }

    @Override
    public void eliminar(Long id) throws SQLException {

    }

    private Camion getCamion(ResultSet rs) throws SQLException {
        Camion a = new Camion();
        a.setId(rs.getLong("ID_CAMION"));
        a.setMatricula(rs.getString("MATRICULA"));

        String tipoCamionString = rs.getString("TIPO_CAMION");
        Tipos tipoCamion = Tipos.valueOf(tipoCamionString.toUpperCase());
        a.setTipoCamion(tipoCamion);

        a.setModelo(rs.getInt("MODELO"));

        String marcaString = rs.getString("MARCA");
        Marcas marca = Marcas.valueOf(marcaString.toUpperCase());
        a.setMarca(marca);

        a.setCapacidad(rs.getInt("CAPACIDAD"));
        a.setKilometraje(rs.getFloat("KILOMETRAJE"));
        a.setDisponibilidad(rs.getBoolean("DISPONIBILIDAD"));
        return a;
    }
}
