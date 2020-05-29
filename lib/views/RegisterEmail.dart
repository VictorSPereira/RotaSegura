import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ROTA SEGURA"),
        ),
        body: Container(
            child: Form(
                child:
                _formUI()
            )
        ),
      ),
    );
  }

  Widget _formUI() {
    return new
    Container(
        padding: EdgeInsets.all(25.0),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text.rich(
                TextSpan(
                    text: "Nome ",
                    children: <TextSpan> [TextSpan(text: "*",style: TextStyle(color: Colors.red))]
                )
            ),
            new Container(
              width: 370,
              child: new TextFormField(
                decoration: new InputDecoration(
                  prefixIcon:  Icon(Icons.person_pin, size: 40.0, color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            new Text.rich(
                TextSpan(
                    text: "Sobrenome ",
                    children: <TextSpan> [TextSpan(text: "*",style: TextStyle(color: Colors.red))]
                )
            ),
            new Container(
              width: 370,
              child: new TextFormField(
                decoration: new InputDecoration(
                  border:  OutlineInputBorder(),
                ),
              ),
            ),

            new Text("Data de Nascimento:"),
            new Container(
              width: 370,
              child:
              new TextFormField(
                decoration: new InputDecoration(
                  prefixIcon: Icon(Icons.date_range, size: 40.0, color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            new Text.rich(
                TextSpan(
                    text: "CPF ",
                    children: <TextSpan> [TextSpan(text: "*",style: TextStyle(color: Colors.red))]
                )
            ),
            new Container(
              width: 370,
              child:
              new TextFormField(
                decoration: new InputDecoration(
                  prefixIcon: Icon(Icons.chrome_reader_mode, size: 40.0, color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            new Text.rich(
                TextSpan(
                    text: "E-mail ",
                    children: <TextSpan> [TextSpan(text: "*",style: TextStyle(color: Colors.red))]
                )
            ),
            new Container(
              width: 370,
              child:
              new TextFormField(
                decoration: new InputDecoration(
                  prefixIcon: Icon(Icons.email, size: 40.0, color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            new Text.rich(
                TextSpan(
                    text: "Confirmar E-mail ",
                    children: <TextSpan> [TextSpan(text: "*",style: TextStyle(color: Colors.red))]
                )
            ),
            new Container(
              width: 370,
              child:
              new TextFormField(
                decoration: new InputDecoration(
                  border:  OutlineInputBorder(),
                ),
              ),
            ),

            new Text.rich(
                TextSpan(
                    text: "Senha ",
                    children: <TextSpan> [TextSpan(text: "*",style: TextStyle(color: Colors.red))]
                )
            ),
            new Container(
              width: 370,
              child:
              new TextFormField(
                decoration: new InputDecoration(
                  prefixIcon: Icon(Icons.lock, size: 40.0, color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            new Text.rich(
                TextSpan(
                    text: "Confirmar Senha ",
                    children: <TextSpan> [TextSpan(text: "*",style: TextStyle(color: Colors.red))]
                )
            ),
            new Container(
              width: 370,
              child:
              new TextFormField(
                decoration: new InputDecoration(
                  border:  OutlineInputBorder(),
                ),
              ),
            ),

            new SizedBox(height: 15.0),

            new MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green)
                ),
                minWidth: 200,
                color: Colors.green,
                disabledColor: Colors.green[600],
                textColor: Colors.white,
                disabledTextColor: Colors.white,
                child: new Text('Cadastrar'),
                onPressed: () {}
            )
          ],
        ));
  }
}

