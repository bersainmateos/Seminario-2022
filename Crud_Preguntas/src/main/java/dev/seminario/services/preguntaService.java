package dev.seminario.services;

import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;

import dev.seminario.entity.Pregunta;

public interface preguntaService {

	public List<Pregunta> listarPreguntas();
	public String actualizarPregunta(JsonNode body);
	public String eliminarPregunta(JsonNode body);
	public String agregarPregunta(JsonNode body);
	public String agregarCatalogoPregunta(JsonNode body);
	public String consultaCatalogoPregunta();
	public String agregarNuevaCatalogoPregunta(JsonNode body, int tipo);
}
