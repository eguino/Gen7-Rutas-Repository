package com.eguino.app.rutas.services;

import com.eguino.app.rutas.models.Camion;
import com.eguino.app.rutas.models.Cargamento;
import com.eguino.app.rutas.repositories.CamionesRepository;
import com.eguino.app.rutas.repositories.CargamentoRepository;
import com.eguino.app.rutas.repositories.IRepository;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class CargamentoService implements IService<Cargamento> {
    private IRepository<Cargamento> cargamentoRepo;

    public CargamentoService(Connection conn) {
        cargamentoRepo = new CargamentoRepository(conn);
    }

    @Override
    public List<Cargamento> listar() {
        return List.of();
    }

    @Override
    public Optional<Cargamento> getById(Long id) {
        return Optional.empty();
    }

    @Override
    public void guardar(Cargamento cargamento) {
        try{
            cargamentoRepo.guardar(cargamento);
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public void eliminar(Long id) {

    }
}
