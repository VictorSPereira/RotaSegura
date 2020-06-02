import 'package:mysql1/mysql1.dart';
import 'package:rotasegura/helpers/stateMachine.dart';

class User {
   int id = null;
   String username = "";
   String email = "";
   String password = "";
   int cpf = null;
   int cep = null;
   String date = "";
   int status = null;
   String photo = "";
   var conn;

  User(int id, String username, String email, String password, 
        int cpf, int cep, String date, int status, String photo){

    this.id = id;
    this.username = username;
    this.email = email;
    this.password = password;
    this.cpf = cpf;
    this.cep = cep;
    this.date = date;
    this.status = status;
    this.photo = photo;
  }
/*
  Results insertUserDB() {
   StateMachine.connectDB();
   try{
      result = conn.query('INSERT INTO `usuario`'+
      '(`iddb_rota`, `username_rota`, `email_rota`, `passwd_rota`, `cep_rota`,'+
      ' `cpf_rota`, `date_rota`, `status_rota`, `photo_rota`) '+
      'VALUES (3, teste,email@,senha,3333,2222,22/11,2,photo)');
   }
   catch(error) {
     print("ERRO INSERÇÃO: " + error.toString());
   }
   print(result);
   return result;
  }
*/
}