import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.bettinghouse.User;

public aspect Logger {
private SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
 
    pointcut registerUser() : call(* com.bettinghouse.BettingHouse.successfulSignUp(..));

    after() returning : registerUser() {
        User user = (User)thisJoinPoint.getArgs()[0];
        recordAction("Register.txt", user, "Usuario registrado");
    }

}