import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.orange,
          ),
        ),
        AspectRatio(
          aspectRatio: 1.8,
          child: Container(
            color: Colors.white,            
            child: Padding(           
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Image.asset("assets/logo/RS_logo_2.png"),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

