/**
 * 
 */
package dev.seminario.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;

import dev.seminario.entity.Pregunta;
import dev.seminario.repository.preguntaRepository;
import dev.seminario.services.preguntaService;

/**
 * @author bersa
 *
 */

@Service
public class preguntaServiceImp implements preguntaService{
	
	private static final Logger logger = LoggerFactory.getLogger(preguntaServiceImp.class);
	
	@Autowired
	preguntaRepository repository;

	@Override
	public String consultaCatalogoPregunta() {
		return repository.getCatalogoPregunta();
	}

	@Override
	public List<Pregunta> listarPreguntas() {
		return repository.findAll();
	}


	@Override
	public String actualizarPregunta(JsonNode body) {
		logger.info("idpregunta: "+body.get("idpregunta").asInt()+"\nPregunta: "+body.get("pregunta").asText());
		repository.updatePregunta(body.get("idpregunta").asInt(), body.get("pregunta").asText());
		
		return "Actualización exitosa!";
	}

	@Override
	public String eliminarPregunta(JsonNode body) {
		logger.info("idpregunta: "+body.get("idpregunta").asInt());
		repository.deletePregunta(body.get("idpregunta").asInt(),body.get("status").asBoolean());
		
		return "Eliminación exitosa!";
	}

	@Override
	public String agregarPregunta(JsonNode body) {
		logger.info("idpregunta: "+body.get("pregunta").asText());
		repository.addPregunta(body.get("pregunta").asText());
		
		return "Se agrego correctamente!";
	}

	@Override
	public String agregarCatalogoPregunta(JsonNode body) {
		logger.info("json: "+body.toString());
		
		return repository.addCatalogoPregunta(body.toString());
	}

	@Override
	public String agregarNuevaCatalogoPregunta(JsonNode body, int tipo) {
		logger.info("json: "+body.toString());
		
		return repository.addNewCatalogoPregunta(body.toString(),tipo);
	}

}


























