package dev.seminario.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dev.seminario.repository.administradorRepository;
import dev.seminario.services.administradorService;


@Service
public class administradorServiceImpl implements administradorService{

	@Autowired
	administradorRepository repository;
	
	
	@Override
	public String login(String correo, String contrasena) {
		return repository.administrador(correo, contrasena);
	}

}
