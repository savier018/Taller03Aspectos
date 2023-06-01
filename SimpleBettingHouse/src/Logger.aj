import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.bettinghouse.User;

public aspect Logger {
private SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
 
    pointcut registroUsuario() : call(* com.bettinghouse.BettingHouse.successfulSignUp(..));
    pointcut loginUserylogoutUser() : (call(* com.bettinghouse.BettingHouse.effectiveLogIn(..)))||(call(* com.bettinghouse.BettingHouse.effectiveLogOut(..)));

    after() returning : registroUsuario() {
        User user = (User)thisJoinPoint.getArgs()[0];
        grabadoArchivo("Register.txt", user, "Usuario registrado");
        
    }

    after() returning : loginUserylogoutUser() {
        User user = (User)thisJoinPoint.getArgs()[0];
        if (thisJoinPoint.getSignature().getName().equals("effectiveLogIn")) {
        	grabadoArchivo("Log.txt", user, "Sesion iniciada");	

        }else if (thisJoinPoint.getSignature().getName().equals("effectiveLogout")) {
        	
    	grabadoArchivo("Log.txt", user, "Sesion cerrada");	
    }
    }
    private void grabadoArchivo(String fileName, User user, String actionType) {
    	File file = new File(fileName);
    	String time = sdf.format(Calendar.getInstance().getTime());

    	try (PrintWriter out = new PrintWriter(new FileWriter(file, true))) {
    	String message;
    	if (actionType.equals("Usuario registrado")) {
    	message = actionType + ": [nickname=" + user.getNickname() + ", password=" + user.getPassword() + "] Fecha: [" + time + "]";
    	} else {
    	message = actionType + " por usuario: [" + user.getNickname() + "] Fecha: [" + time + "]";
    	}
    	System.out.println(message);
    	out.println(message);
    	} catch (IOException e) {
    	e.printStackTrace();
    	}
    }
	}

    