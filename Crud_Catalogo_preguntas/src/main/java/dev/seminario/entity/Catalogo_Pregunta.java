package dev.seminario.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "pregunta")

public class Catalogo_Pregunta {

	@Id
	@Column(name = "idpregunta")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long idPregunta;
	
	@Column(name = "nuevapregunta")
	private String nuevaPregunta;
	
	@Column(name = "fechacreacion")
	private String fechaCreacion;
	
	@Column(name = "status")
	private boolean status;

	public Long getIdpregunta() {
		return idPregunta;
	}

	public void setIdpregunta(Long idpregunta) {
		this.idPregunta = idpregunta;
	}

	public String getNuevaPregunta() {
		return nuevaPregunta;
	}

	public void setNuevaPregunta(String nuevaPregunta) {
		this.nuevaPregunta = nuevaPregunta;
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
