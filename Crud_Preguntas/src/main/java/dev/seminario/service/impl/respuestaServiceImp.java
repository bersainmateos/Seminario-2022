/**
 * 
 */
package dev.seminario.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dev.seminario.entity.Respuesta;
import dev.seminario.repository.respuestaRepository;
import dev.seminario.services.respuestaService;

/**
 * @author bersa
 *
 */
@Service
public class respuestaServiceImp implements respuestaService{

	@Autowired
	respuestaRepository repository;
	
	@Override
	public String consultaCatalogoRespuesta() {
		return repository.getCatalogoRespuesta();
	}

	@Override
	public List<Respuesta> listarRespuestas() {
		return repository.findAll();
	}


}
