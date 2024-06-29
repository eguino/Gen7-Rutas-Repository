package com.eguino.app.rutas.models;

public class Cargamento {
    private Long idCargamento;
    private Long ruta_id;
    private String descripcion;
    private Float peso;
    private Integer estatus;

    public Long getIdCargamento() {
        return idCargamento;
    }

    public void setIdCargamento(Long idCargamento) {
        this.idCargamento = idCargamento;
    }

    public Long getRuta_id() {
        return ruta_id;
    }

    public void setRuta_id(Long ruta_id) {
        this.ruta_id = ruta_id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Float getPeso() {
        return peso;
    }

    public void setPeso(Float peso) {
        this.peso = peso;
    }

    public Integer getEstatus() {
        return estatus;
    }

    public void setEstatus(Integer estatus) {
        this.estatus = estatus;
    }
}
