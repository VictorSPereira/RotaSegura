import 'dart:async';

import 'package:mysql1/mysql1.dart';

const timeout = const Duration(seconds: 3);
const ms = const Duration(milliseconds: 1);
var settings = new ConnectionSettings(
    host: 'rotasegura.mysql.uhserver.com',
    port: 3306,
    user: 'aaraujo',
    password: 'rota.2020',
    db: 'rotasegura');
var conn;
Results result;

abstract class StateMachine {
  static Future<bool> connectDB() async {
    print('VOCONECTA!');
    try {
      conn = await MySqlConnection.connect(settings);
      return true;
    } catch (Exception) {
      print('NUMFOI!');
      return false;
    }
  }

  static Future<Results> selectDB() async {
    connectDB();
    try {
      result = await conn.query('select * from tipo_ocorrencia');
    } catch (Exception) {
      print('SELECT NUMDEU!');
    }
    print(result.toString());
    return result;
  }

  static Future<Results> insertDB() async {
    connectDB();
    try {
      result = conn.query(
          'INSERT INTO `tipo_ocorrencia`(`idtbtipoocorrencia_rota`, `tipoocorrencia_rota`) VALUES (1, "teste")');
    } catch (Exception) {}
    print(result.toString());
    return result;
  }

  static Future<Results> registerUser(String nome, sobre, data, cpf, cep, email, senha) async {
    connectDB();
    var resultt;
    print(nome);
    try {
      resultt = await conn.query(
          "INSERT INTO `rotasegura`.`usuario` (`username_rota`, `email_rota`, `passwd_rota`, `cep_rota`, `cpf_rota`, `date_rota`, `status_rota`, `photo_rota`) VALUES (?, ?, ?, ?, ?, ?, ?, ?); ",
     [nome, email, senha, cep, cpf, data, '1', '']
          );
    } catch (error) {
      print("ERRO INSERÇÃO: " + error.toString());
    }
    print(resultt.toString());
    return resultt;
  }

  static Future<Results> loginDB() async {
    connectDB();
    try {
      result = await conn.query('select * from tipo_ocorrencia');
    } catch (Exception) {
      print('SELECT NUMDEU!');
    }
    print(result.toString());
    return result;
  }
}
 //INSERT INTO `rotasegura`.`usuario` (`iddb_rota`, `username_rota`, `email_rota`, `passwd_rota`, `cep_rota`, `cpf_rota`, `date_rota`, `status_rota`, `photo_rota`) VALUES (NULL, 'user', 'email', 'pass', '1300000', '400000', '30/01', '1', 'photo');      
          