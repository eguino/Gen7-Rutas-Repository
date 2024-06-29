package com.eguino.app.rutas.repositories;

import com.eguino.app.rutas.models.Cargamento;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class CargamentoRepository implements IRepository<Cargamento> {
    private Connection conn;

    public CargamentoRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Cargamento> listar() throws SQLException {
        return List.of();
    }

    @Override
    public Cargamento getById(Long id) throws SQLException {
        return null;
    }

    @Override
    public void guardar(Cargamento cargamento) throws SQLException {
        String sql = "";
        if (cargamento.getIdCargamento() != null && cargamento.getIdCargamento() > 0) {
            sql = "update cargamento set ruta_id=?, descripcion=?, " +
                    "peso=?, estatus=? " +
                    "where id_cargamento=?";
        } else {
            sql = "insert into cargamento(id_cargamento, ruta_id, " +
                    "descripcion, peso, estatus) " +
                    "values (SEQUENCE2.NEXTVAL,?,?,?,?)";
        }
        try (PreparedStatement stmt = conn.prepareStatement(sql)){
            if(cargamento.getIdCargamento() != null && cargamento.getIdCargamento() > 0){
                stmt.setLong(1,cargamento.getRuta_id());
                stmt.setString(2,cargamento.getDescripcion());
                stmt.setFloat(3,cargamento.getPeso());
                stmt.setInt(4,cargamento.getEstatus());
                stmt.setLong(5, cargamento.getIdCargamento());
            } else {
                stmt.setLong(1,cargamento.getRuta_id());
                stmt.setString(2,cargamento.getDescripcion());
                stmt.setFloat(3,cargamento.getPeso());
                stmt.setInt(4,cargamento.getEstatus());
            }
            stmt.executeUpdate();
        }
    }

    @Override
    public void eliminar(Long id) throws SQLException {

    }
}
