/**													INTERACCIÓN CON LA BASE DE DATOS,
 * 			SE REALIZA CRUD PARA INTERACTUAR CON LA BASE DE DATOS, OBTENIENDO LAS RESPUESTAS EN FORMATO JSON 
 */
package dev.seminario.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import dev.seminario.entity.Pregunta;

/**
 * @author Bersain Mateos Méndez
 *
 */
public interface preguntaRepository extends JpaRepository <Pregunta,Long>{

	@Transactional
	@Modifying  
	@Query(value="update pregunta set nuevapregunta=:nuevaPregunta where idpregunta=:id", nativeQuery = true)
	int updatePregunta(@Param("id") Integer id,@Param("nuevaPregunta") String nuevaPregunta);
	
	@Transactional
	@Modifying  
	@Query(value="insert into pregunta values (default,:nuevaPregunta, default,default)", nativeQuery = true)
	int addPregunta(@Param("nuevaPregunta") String nuevaPregunta);
	
	@Transactional
	@Modifying  
	@Query(value="update pregunta set status=:status where idpregunta=:id", nativeQuery = true)
	int deletePregunta(@Param("id") Integer id,@Param("status") boolean status);
	
	@Query(value="select catalogo_pregunta()", nativeQuery = true)
	public String getCatalogoPregunta();
	
	@Query(value="select agregar_catalogo_pregunta(:dataJSON)", nativeQuery = true)
	public String addCatalogoPregunta(@Param("dataJSON") String dataJSON);
	
	@Query(value="select agregar_nuevas_pregunta_catalogo(:dataJSON,:tipo,:status)", nativeQuery = true)
	public String addNewCatalogoPregunta(@Param("dataJSON") String dataJSON, @Param("tipo") int tipo);
	
	
}