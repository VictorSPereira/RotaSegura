import 'package:flutter/material.dart';
import 'package:rotasegura/views/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.orange),
        checkerboardOffscreenLayers: false,
        home: Home());
  }
}

//indicadores e lista