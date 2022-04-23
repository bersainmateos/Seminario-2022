package dev.seminario.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import dev.seminario.DTO.ResponseHandler;
import dev.seminario.services.administradorService;

@RestController

@RequestMapping("/api/encuesta")
public class ApiRest {
	
	private static final Logger logger = LoggerFactory.getLogger(ApiRest.class);
	@Autowired
	private administradorService admin;
	ObjectMapper mapper = new ObjectMapper();
	
	@PostMapping("/login")
	public ResponseEntity<Object> login(@RequestBody String body) throws JsonProcessingException  {
		try {
			
			JsonNode bodyJson = mapper.readTree(body);

			return ResponseHandler.generateResponse(HttpStatus.OK, admin.login(bodyJson.get("correo").asText(), bodyJson.get("contrasena").asText()),null);
		}catch(Exception w) {
			
			logger.info("Ocurrio un error en :::"+w.getMessage());
			return ResponseHandler.InternalServerError(HttpStatus.INTERNAL_SERVER_ERROR);
			
		}
	}
}