package dev.seminario.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import dev.seminario.entity.Administrador;

public interface administradorRepository extends JpaRepository <Administrador,Long>{
	
			@Query(value="select login(:correo,:contrasena)", nativeQuery = true)
			public String administrador(@Param("correo") String correo,@Param("contrasena") String contrasena);
}
