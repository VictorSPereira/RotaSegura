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
MySqlConnection conn;
Results result;

abstract class StateMachine {
  static Future<bool> connectDB() async {
    print('VOCONECTA!');
    print(conn.toString());
    try {
      conn = await MySqlConnection.connect(settings);
      return true;
    } catch (Exception) {
      print('Erro na conexao com o banco!');
      return false;
    }
  }

static Future<bool> buscarEmail(String email) async {
    try {
      print(email);
      connectDB();
      result = await conn
          .query("SELECT email_rota FROM usuario WHERE email_rota = ?", [email]);
      print(result);
    } catch (Exception) {
      print('Erro na consulta do email');
      return await Future.value(true);
    }
    if (result != null && result.isNotEmpty) {
      print('existe ');
      return await Future.value(true);
    } else {
      print('nao existe');
      return await Future.value(false);
    }
  }

  static Future<bool> buscarCPF(String cpf) async {
    try {
      print(cpf);
      connectDB();
      result = await conn
          .query("SELECT cpf_rota FROM usuario WHERE cpf_rota = ?", [cpf]);
      print(result);
    } catch (Exception) {
      print('Erro na consulta do cpf');
      return await Future.value(true);
    }
    if (result != null && result.isNotEmpty) {
      print('existe ');
      return await Future.value(true);
    } else {
      print('nao existe');
      return await Future.value(false);
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
      result = await conn.query(
          'INSERT INTO `tipo_ocorrencia`(`idtbtipoocorrencia_rota`, `tipoocorrencia_rota`) VALUES (1, "teste")');
    } catch (Exception) {}
    print(result.toString());
    return result;
  }

   static Future<Results> recuveryUser(id) async {
    connectDB();
    try {
      result = conn.query(
          "SELECT `username_rota`, `lastname_rota`, `email_rota`, `cep_rota`, `cpf_rota`, `date_rota` FROM `usuario` where iddb_rota = 21");//, [id]
    } catch (Exception) {}
    return await Future.value(result);
  }

  static Future<int> registerUser(
      String nome,sobre, data, cpf, cep, email, senha) async {
    connectDB();
    var resultt;
    try {
      connectDB();
      resultt = await conn.query(
          "INSERT INTO `rotasegura`.`usuario` (`username_rota`, `lastname_rota` ,`email_rota`, `passwd_rota`, `cep_rota`, `cpf_rota`, `date_rota`, `status_rota`, `photo_rota`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
          [nome,sobre, email, senha, cep, cpf, data, '1', 'default']);
    } catch (error) {
      return error;
    }
    return resultt;
  }

  static Future<int> loginRota(String email, pass) async {
    var resultt;
    try {
      connectDB();
      resultt = await conn.query(
          "SELECT iddb_rota, email_rota, username_rota FROM usuario WHERE email_rota = ? and passwd_rota = ?",
          [
            email,
            pass,
          ]);
    } catch (error) {}
    int iduser;
    //print(resultt.toString());
    for (var row in resultt) {
      print('Name: ${row[0]}, email: ${row[1]}');
      iduser = row[0];
    }
    if (iduser == null || resultt == null) {
      return 0;
    }
    //print(iduser);
    return iduser;
  }
}
//INSERT INTO `rotasegura`.`usuario` (`iddb_rota`, `username_rota`, `email_rota`, `passwd_rota`, `cep_rota`, `cpf_rota`, `date_rota`, `status_rota`, `photo_rota`) VALUES (NULL, 'user', 'email', 'pass', '1300000', '400000', '30/01', '1', 'photo');
