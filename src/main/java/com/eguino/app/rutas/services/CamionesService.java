package com.eguino.app.rutas.services;

import com.eguino.app.rutas.models.Camion;
import com.eguino.app.rutas.repositories.CamionesRepository;
import com.eguino.app.rutas.repositories.IRepository;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class CamionesService implements IService<Camion> {
    private IRepository<Camion> camionesRepo;

    public CamionesService(Connection conn) {
        camionesRepo = new CamionesRepository(conn);
    }

    @Override
    public List<Camion> listar() {
        try{
            return camionesRepo.listar();
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public Optional<Camion> getById(Long id) {
        return Optional.empty();
    }

    @Override
    public void guardar(Camion camion) {
        try{
            camionesRepo.guardar(camion);
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public void eliminar(Long id) {

    }
}