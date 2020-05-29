import 'package:flutter/material.dart';
import 'package:rotasegura/custom/social_icons.dart';
import 'package:rotasegura/views/CadastroUsuario.dart';

class OpcoesCadastroUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(context),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text("Opção de Cadastro"),
    );
  }

  Widget body(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              height: 80,
              child: Image.asset(
                "assets/logo/RS_logo_3.png",
                width: 250,
              )),
          Divider(
            color: Colors.black12,
            height: 5,
          ),
          Container(
            height: 80,
            child: Center(
              child: Text(
                "Inscreva-se é gratis",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          _buttonTipoCadastro(
              titulo: "Twitter", icon: Social.twitter, color: Colors.grey),
          SizedBox(height: 20),
          _buttonTipoCadastro(
              titulo: "Google", icon: Social.google, color: Colors.grey),
          SizedBox(height: 20),
          _buttonTipoCadastro(
              titulo: "Facebook", icon: Social.facebook, color: Colors.grey),
          Divider(
            color: Colors.black12,
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: _buttonTipoCadastro(
                titulo: "E-mail",
                icon: Social.email,
                color: Colors.orange,
                onTap: () {
                  navigatorTo(context, CadastroUsuario());
                }),
          )
        ],
      ),

    );
  }
  
  void navigatorTo(BuildContext context, Widget pagina) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => pagina));
  }

  Widget _buttonTipoCadastro(
      {String titulo, IconData icon, Color color, Function onTap}) {
    return Container(
      decoration:

          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),

      width: 300,
      child: ListTile(
        onTap: onTap,
        title:

            Text(titulo, style: TextStyle(fontSize: 16, color: Colors.white)),

        leading: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

}

