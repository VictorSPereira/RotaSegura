import 'package:flutter/material.dart';
import 'package:rotasegura/helpers/stateMachine.dart';
import 'package:rotasegura/helpers/user.dart';
import 'package:rotasegura/widgets/CustomTextFormField.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final GlobalKey<FormState> _keyformCadastroUsuario = GlobalKey<FormState>();
  TextEditingController _controllerNome;
  TextEditingController _controllerSobrenome;
  TextEditingController _controllerDataNascimento;
  TextEditingController _controllerCpf;
  TextEditingController _controllerCep;
  TextEditingController _controllerEmail;
  TextEditingController _controllerConfirmeEmail;
  TextEditingController _controllerSenha;
  TextEditingController _controllerConfirmeSenha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text("Cadastro de Usuário"),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: formCadastroUsuario(),
          ),
          Divider(
            height: 20,
          ),
          Container(
            height: 40,
            child: Image.asset(
              "assets/logo/RS_logo_3.png",
            ),
          )
        ],
      ),
    );
  }

  Widget formCadastroUsuario() {
    return SingleChildScrollView(
      child: Form(
        key: _keyformCadastroUsuario,
        child: Column(
          children: <Widget>[
            CustomTextFormField.textFormField(
                controller: _controllerNome, label: "Nome"),
            CustomTextFormField.textFormField(
                controller: _controllerSobrenome, label: "Sobrenome"),
            CustomTextFormField.textFormDataField(context,
                controller: _controllerDataNascimento,
                label: "Data de nascimento"),
            CustomTextFormField.textFormField(
                controller: _controllerCpf, label: "CPF"),
            CustomTextFormField.textformCepField(
              controller: _controllerCep, label: "CEP"),
            CustomTextFormField.textFormField(
                controller: _controllerEmail,
                label: "E-mail",
                keyboard: TextInputType.emailAddress),
            CustomTextFormField.textFormField(
                controller: _controllerConfirmeEmail,
                label: "Confirme o E-mail",
                keyboard: TextInputType.emailAddress),
            CustomTextFormField.textFormField(
                controller: _controllerSenha,
                label: "Senha",
                obscureText: true),
            CustomTextFormField.textFormField(
                controller: _controllerConfirmeSenha,
                label: "Confirme a senha",
                obscureText: true),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0)),
                    color: Colors.orange,
                    child: Text("Cadastrar"),
                    onPressed: () {
                        print('IAI');        
                        StateMachine.registerUser();
                    },
                  )
          ],
        ),
      ),
    );
  }
}

