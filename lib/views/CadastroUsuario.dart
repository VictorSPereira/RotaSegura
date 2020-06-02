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
  var _controllerSobrenome = TextEditingController();
  var _controllerDataNascimento = TextEditingController();
  var _controllerCpf = TextEditingController();
  var _controllerCep = TextEditingController();
  var _controllerEmail = TextEditingController();
  var _controllerConfirmeEmail = TextEditingController();
  var _controllerSenha = TextEditingController();
  var _controllerConfirmeSenha = TextEditingController();

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
                print('chamando funcao sql');
                String nome = _controllerNome.text;
                String sobre = _controllerSobrenome.text;
                String data = _controllerDataNascimento.text;
                String cpf = _controllerCpf.text;
                String cep = _controllerCep.text;
                String email = _controllerEmail.text;
                String cEmail = _controllerConfirmeEmail.text;
                String senha = _controllerSenha.text;
                String cSenha = _controllerConfirmeSenha.text;
                print(nome);
                if(email == cEmail && senha == cSenha){
                  nome = nome + ' ' + sobre;
                  data ='30/04/1995';
                  StateMachine.registerUser(nome, sobre, data, cpf, cep, email, senha);
                }
                
              },
            )
          ],
        ),
      ),
    );
  }
}
