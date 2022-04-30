 package dev.seminario.DTO;


import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class ResponseHandler {
    
    public static ResponseEntity<Object> generateResponse(HttpStatus status, String responseObj, Object data) throws JsonProcessingException {
        
    	Map<String, Object> map = new HashMap<String, Object>();
    	ObjectMapper mapper = new ObjectMapper();

    	if(responseObj == null){
            map.put("resultado", data);
        }else{
            map.put("resultado", mapper.readTree(responseObj));
        }
    	
        return new ResponseEntity<Object>(map,status);

    }


    public static ResponseEntity<Object> generateResponseOK(HttpStatus status, String responseObj) throws JsonProcessingException {
        
    	Map<String, Object> map = new HashMap<String, Object>();

        map.put("mensaje", responseObj);
        map.put("folio", getFolio());
        map.put("status",true);

            
        return new ResponseEntity<Object>(map,status);
    }

    
    public static ResponseEntity<Object> InternalServerError(HttpStatus status) throws JsonProcessingException {
        
    	Map<String, Object> map = new HashMap<String, Object>();

            map.put("mensaje", "Error interno en el servidor");
            map.put("folio", getFolio());
            map.put("status", false);
                       
        return new ResponseEntity<Object>(map,status);
    }
    
    
    private static String getFolio() {
    	
        Random aleatorio = new Random();

        String alfa = "abcdefghijklmnopqrstuvwxz";
        String cadena = ""; 
        String aux="";
        int posicion=0;
        
       for(int i=0; i < 4; i++) {
    	   
        aux="";

        	for(int j=0; j < 6; j++) {
            	posicion=(int)(aleatorio.nextDouble() * alfa.length()-1);
            	aux+= alfa.charAt(posicion);
        	}
        	
        	if(i == 0) {

            	cadena+=aux;
        	
            }else {
            
                cadena+="-"+aux;
        	
            }
        	
        }

    	return cadena;
    }
}