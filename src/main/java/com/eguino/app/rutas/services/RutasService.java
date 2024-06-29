package com.eguino.app.rutas.services;

import com.eguino.app.rutas.models.Camion;
import com.eguino.app.rutas.models.Chofer;
import com.eguino.app.rutas.models.Ruta;
import com.eguino.app.rutas.repositories.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class RutasService implements IRutasService {
    private IRepository<Chofer> choferesRepo;
    private IRepository<Camion> camionesRepo;
    private IRutasRepository rutasRepository;

    public RutasService(Connection conn){
        this.choferesRepo = new ChoferesRepository(conn);
        this.camionesRepo = new CamionesRepository(conn);
        this.rutasRepository = new RutasRepository(conn);
    }

    @Override
    public List<Camion> listarCamiones() {
        try{
            return camionesRepo.listar();
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public List<Chofer> listarChoferes() {
        try{
            return choferesRepo.listar();
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public Long guardarReturnId(Ruta ruta) {
        try{
            return rutasRepository.guardarReturnId(ruta);
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public List<Ruta> listar() {
        try{
            return rutasRepository.listar();
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public Optional<Ruta> getById(Long id) {
        return Optional.empty();
    }

    @Override
    public void guardar(Ruta ruta) {
        System.out.println("Entré al service :D "+ruta);
        try{
            rutasRepository.guardar(ruta);
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    public void guardarId(Ruta ruta) {
        try{
            rutasRepository.guardarReturnId(ruta);
        } catch (SQLException e){
            throw new RuntimeException(e.getMessage(),e.getCause());
        }
    }

    @Override
    public void eliminar(Long id) {

    }
}
