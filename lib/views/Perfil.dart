import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotasegura/widgets/CustomTextFormField.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final GlobalKey<FormState> _keyformPerfilUsuario = GlobalKey<FormState>();
  TextEditingController _controllerNome;
  TextEditingController _controllerSobrenome;
  TextEditingController _controllerDataNascimento;
  TextEditingController _controllerCpf;
  TextEditingController _controllerEmail;
  TextEditingController _controllerSenha;
    TextEditingController _controllerSenhaConfirmar;

  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.orange,
      elevation: 0,
      title: Text("Perfil"),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            _avatar(),
            _barraInformacoes(),
            Expanded(child: _formPerfil())
          ],
        ),
      ],
    );
  }

  Widget _avatar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 60,
          child: new Icon(
            Icons.person,
            color: Colors.white,
            size: 50,
          ),
        )
      ],
    );
  }

  Widget _formPerfil() {
    return SingleChildScrollView(
      child: Form(
        key: _keyformPerfilUsuario,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: <Widget>[
              CustomTextFormField.textFormField(
                  controller: _controllerNome,
                  label: "Nome",
                  enabled: _editing,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              CustomTextFormField.textFormField(
                  controller: _controllerSobrenome,
                  label: "Sobrenome",
                  enabled: _editing,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              CustomTextFormField.textFormDataField(context,
                  controller: _controllerDataNascimento,
                  label: "Data de nascimento",
                  enabled: _editing,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              CustomTextFormField.textFormField(
                  controller: _controllerCpf,
                  label: "CPF",
                  enabled: false,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              CustomTextFormField.textformCepField(
                  controller: _controllerCpf,
                  enabled: _editing,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              CustomTextFormField.textFormField(
                  controller: _controllerEmail,
                  enabled: false,
                  label: "E-mail",
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  keyboard: TextInputType.emailAddress),
              CustomTextFormField.textFormField(
                  enabled: _editing,
                  controller: _controllerSenha,
                  label: "Senha",
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  obscureText: true),
              CustomTextFormField.textFormField(
                  enabled: _editing,
                  controller: _controllerSenhaConfirmar,
                  label: "Confirmar senha",
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  obscureText: true),
              _editing ? _actionButtons() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _barraInformacoes() {
    return ListTile(
      title: Text("Informações",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      trailing: !_editing
          ? _getIcon(icon: Icons.edit, onTap: _editingForm)
          : SizedBox(),
    );
  }

  Widget _getIcon(
      {double sizeIcon = 16.0,
      IconData icon = Icons.info,
      double radius = 14.0,
      Function onTap}) {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.black,
        radius: radius,
        child: new Icon(
          icon,
          color: Colors.white,
          size: sizeIcon,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _actionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: new Text("Salvar"),
              textColor: Colors.white,
              color: Colors.green,
              onPressed: _editingForm,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0)),
            ),
            RaisedButton(
              child: new Text("Cancelar"),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: _editingForm,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0)),
            )
          ]),
    );
  }

  _editingForm() {
    setState(() {
      _editing = !_editing;
    });
  }
}
