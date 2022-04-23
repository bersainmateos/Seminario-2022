package dev.seminario.services;

import java.util.List;

import dev.seminario.entity.Respuesta;

public interface respuestaService {
	
	public String consultaCatalogoRespuesta();
	public List<Respuesta> listarRespuestas();
}
