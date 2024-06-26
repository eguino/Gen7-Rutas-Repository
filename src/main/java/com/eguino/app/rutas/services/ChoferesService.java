package com.eguino.app.rutas.services;

import com.eguino.app.rutas.models.Chofer;
import com.eguino.app.rutas.repositories.ChoferesRepository;
import com.eguino.app.rutas.repositories.IRepository;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class ChoferesService implements IService<Chofer> {
    private IRepository<Chofer> choferesRepo;

    public ChoferesService(Connection conn) {
        choferesRepo = new ChoferesRepository(conn);
    }

    @Override
    public List<Chofer> listar() {
        try{
            return choferesRepo.listar();
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public Optional<Chofer> getById(Long id) {
        try{
            return Optional.ofNullable(choferesRepo.getById(id));
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public void guardar(Chofer chofer) {
        try{
            choferesRepo.guardar(chofer);
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public void eliminar(Long id) {

    }
}
