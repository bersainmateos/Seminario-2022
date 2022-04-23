package dev.seminario.services;

import com.fasterxml.jackson.databind.JsonNode;

public interface Catalogo_preguntaService {
	
	public String agregarCatalogoPregunta(JsonNode body);
	public String consultaCatalogoPregunta();
	public String agregarNuevaCatalogoPregunta(JsonNode body, int tipo);

}