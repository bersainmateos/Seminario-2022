package dev.seminario.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import dev.seminario.DTO.ResponseHandler;
import dev.seminario.services.Catalogo_preguntaService;

@RestController

@RequestMapping("/api/encuesta")
public class ApiRest {
	
	private static final Logger logger = LoggerFactory.getLogger(ApiRest.class);
	
	@Autowired
	private Catalogo_preguntaService ps;
	ObjectMapper mapper = new ObjectMapper();
	
	@GetMapping("/catalogo/pregunta")
	public ResponseEntity<Object> catalogoPregunta() throws JsonProcessingException  {
		try {
			
			String respuesta=ps.consultaCatalogoPregunta();
			return ResponseHandler.generateResponse(HttpStatus.OK, respuesta,null);
			
		}catch(Exception w) {
			logger.info("Ocurrio un error en :::"+w.getMessage());
			return ResponseHandler.InternalServerError(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	
	@PostMapping("/catalogo/agregar/pregunta")
	public ResponseEntity<Object> agregarCatalogoPregunta(@RequestBody String body) throws JsonProcessingException  {
		try {
			
			JsonNode bodyJson = mapper.readTree(body);
			
			return ResponseHandler.generateResponseOK(HttpStatus.OK, ps.agregarCatalogoPregunta(bodyJson));
		}catch(Exception w) {

			logger.info("Ocurrio un error en :::"+w.getMessage());
			return ResponseHandler.InternalServerError(HttpStatus.INTERNAL_SERVER_ERROR);
			
		}
	}

}