/**
 * 
 */
package dev.seminario.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author bersa
 *
 */


@Entity
@Table(name = "respuesta")
public class Respuesta {
	
	
	@Id
	@Column(name = "idrespuesta")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long idRespuesta;
	
	@Column(name = "nuevarespuesta")
	private String nuevaRespuesta;
	
	@Column(name = "fechacreacion")
	private String fechaCreacion;
	
	@Column(name = "status")
	private boolean status;

	public Long getIdRespuesta() {
		return idRespuesta;
	}

	public void setIdRespuesta(Long idRespuesta) {
		this.idRespuesta = idRespuesta;
	}

	public String getNuevaRespuesta() {
		return nuevaRespuesta;
	}

	public void setNuevaRespuesta(String nuevaRespuesta) {
		this.nuevaRespuesta = nuevaRespuesta;
	}

	public String getFechaCreacion() {
		return fechaCreacion;
	}

	public void setFechaCreacion(String fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
	
	
}
