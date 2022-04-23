package dev.seminario.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "administrador")
public class Administrador {

	@Id
	@Column(name = "idadmin")	
	long idadmin;
	@Column(name = "nombre_admin")
	String nombre_admin;
	@Column(name = "primer_apellido")
	String primer_apellido;
	@Column(name = "segundo_apellido")
	String segundo_apellido;
	@Column(name = "correo")
	String correo;
	@Column(name = "numero_telefono")
	String numero_telefono;
	@Column(name = "contrasena")
	String contrasena;
	
	
	
	public long getIdadmin() {
		return idadmin;
	}
	
	public void setIdadmin(long idadmin) {
		this.idadmin = idadmin;
	}
	
	public String getNombre_admin() {
		return nombre_admin;
	}
	public void setNombre_admin(String nombre_admin) {
		this.nombre_admin = nombre_admin;
	}
	
	public String getPrimer_apellido() {
		return primer_apellido;
	}
	
	public void setPrimer_apellido(String primer_apellido) {
		this.primer_apellido = primer_apellido;
	}
	
	public String getSegundo_apellido() {
		return segundo_apellido;
	}
	
	public void setSegundo_apellido(String segundo_apellido) {
		this.segundo_apellido = segundo_apellido;
	}
	
	public String getCorreo() {
		return correo;
	}
	
	public void setCorreo(String correo) {
		this.correo = correo;
	}
	
	public String getNumero_telefono() {
		return numero_telefono;
	}
	
	public void setNumero_telefono(String numero_telefono) {
		this.numero_telefono = numero_telefono;
	}
	
	public String getContrasena() {
		return contrasena;
	}
	
	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}	
}