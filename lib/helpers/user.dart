import 'package:mysql1/mysql1.dart';
import 'package:rotasegura/helpers/stateMachine.dart';

class User {
   int id = 0;
   String username = "";
   String email = "";
   String password = "";
   String cpf = "";
   String cep = "";
   String date = "";
   int status = 0;
   String photo = "";
   var conn;

  User(int id, String username, String email, String password, 
        String cpf, String cep, String date, int status, String photo){

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

}