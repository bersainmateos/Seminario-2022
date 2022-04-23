/**													INTERACCIÓN CON LA BASE DE DATOS,
 * 			SE REALIZA CRUD PARA INTERACTUAR CON LA BASE DE DATOS, OBTENIENDO LAS RESPUESTAS EN FORMATO JSON 
 */
package dev.seminario.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import dev.seminario.entity.Catalogo_Pregunta;

/**
 * @author Bersain Mateos Méndez
 *
 */
public interface Catalogo_preguntaRepository extends JpaRepository <Catalogo_Pregunta,Long>{

	@Query(value="select catalogo_pregunta()", nativeQuery = true)
	public String getCatalogoPregunta();
	
	@Query(value="select agregar_catalogo_pregunta(:dataJSON)", nativeQuery = true)
	public String addCatalogoPregunta(@Param("dataJSON") String dataJSON);
	
	@Query(value="select agregar_nuevas_pregunta_catalogo(:dataJSON,:tipo,:status)", nativeQuery = true)
	public String addNewCatalogoPregunta(@Param("dataJSON") String dataJSON, @Param("tipo") int tipo);
	
	
}