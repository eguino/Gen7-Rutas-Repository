package com.eguino.app.rutas.services;

import com.eguino.app.rutas.models.Camion;
import com.eguino.app.rutas.models.Chofer;
import com.eguino.app.rutas.models.Ruta;

import java.util.List;

public interface IRutasService extends IService<Ruta> {
    List<Camion> listarCamiones();
    List<Chofer> listarChoferes();
    Long guardarReturnId(Ruta ruta);
}
