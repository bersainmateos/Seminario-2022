/**
 * 
 */
package dev.seminario.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import dev.seminario.entity.Respuesta;

/**
 * @author bersa
 *
 */
public interface respuestaRepository extends JpaRepository<Respuesta, Long>{
	
    @Query(value="select catalogo_respuesta()", nativeQuery = true)
	public String getCatalogoRespuesta();
}
