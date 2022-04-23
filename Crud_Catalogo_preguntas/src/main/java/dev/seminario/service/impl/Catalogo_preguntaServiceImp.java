/**
 * 
 */
package dev.seminario.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;

import dev.seminario.repository.Catalogo_preguntaRepository;
import dev.seminario.services.Catalogo_preguntaService;

/**
 * @author bersa
 *
 */

@Service
public class Catalogo_preguntaServiceImp implements Catalogo_preguntaService{
	
	private static final Logger logger = LoggerFactory.getLogger(Catalogo_preguntaServiceImp.class);
	
	@Autowired
	Catalogo_preguntaRepository repository;

	@Override
	public String consultaCatalogoPregunta() {
		return repository.getCatalogoPregunta();
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


























