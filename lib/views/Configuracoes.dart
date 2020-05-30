import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  bool isSwitched = true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('Receber notificações'),
            //subtitle: Text('Receba alertas de novas ocorrencias na suas regiões favoritas'),
            trailing: Switch(
              value: true,
              onChanged: (val) {},
            ),
          ),
          ListTile(
            title: Text('Receber alerta por email'),
            //subtitle: Text('Hide and show items'),
            trailing: Switch(
              value: true,
              onChanged: (val) {},
            ),
          ),
          ListTile(
            title: Text('Receber alertas antigos'),
            //subtitle: Text('Hide and show items'),

            trailing: Switch(
              value: true,
              onChanged: (val) {},
            ),
          ),
          Container(
            height: 70,
            child: _buildRodape(),
          )
        ],
      ),
    );
  }
}

Widget _buildRodape() {
  return Container(
    color: Colors.white,
    child: Center(
      child: Image.asset(
        "assets/logo/RS_logo_3.png",
        width: 150,
      ),
    ),
  );
}
