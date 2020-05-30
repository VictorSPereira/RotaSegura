import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

Future login() async {
  var teste ='';
  // Open a connection (testdb should already exist)
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'mysql.uhserver.com',
      port: 3306,
      user: 'aaraujo',
      password: 'rota.2020',
      db: 'rotasegura'));

  // Create a table
  //await conn.query('CREATE TABLE users (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255), email varchar(255), age int)');

  // Insert some data
  /* var result = await conn.query(
      'insert into users (name, email, age) values (?, ?, ?)',
      ['Bob', 'bob@bob.com', 25]);
  print('Inserted row id=${result.insertId}');
  */

  // Query the database using a parameterized query
  var email = 'allan-marcello@hotmail.com';
  var pass = 'teste';
  
  var results = await conn.query(
    'SELECT * FROM usuario',
  ); //[email, pass]
  for (var row in results) {
   teste = "${row[0]}";
    print('Name: ${row[0]}');
  }
   

  // Finally, close the connection
  await conn.close();
  
  
}
