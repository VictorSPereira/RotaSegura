import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:rotasegura/helpers/stateMachine.dart';
import 'package:rotasegura/views/home.dart';
import 'package:rotasegura/widgets/CustomTextFormField.dart';
import 'package:date_format/date_format.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:email_validator/email_validator.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final GlobalKey<FormState> _keyformCadastroUsuario = GlobalKey<FormState>();

  TextEditingController _controllerNome;
  TextEditingController _controllerSobrenome;
  TextEditingController _controllerCpf;
  TextEditingController _controllerCep;
  TextEditingController _controllerEmail;
  TextEditingController _controllerSenha;
  TextEditingController _controllerConfirmeSenha;
  DateTime _data = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    _controllerNome = new TextEditingController();
    _controllerSobrenome = new TextEditingController();
    _controllerCpf = new TextEditingController();
    _controllerCep = new TextEditingController();
    _controllerEmail = new TextEditingController();
    _controllerSenha = new TextEditingController();
    _controllerConfirmeSenha = new TextEditingController();

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
              controller: _controllerNome,
              label: "Nome",
            ),
            CustomTextFormField.textFormField(
                controller: _controllerSobrenome, label: "Sobrenome"
                ),
            FlatButton(
              child: new Row(children: <Widget>[
                new Text('Data de Nascimento:  '),
                new Text('${formatDate(_data, [dd, '-', mm, '-', yyyy])}'),
                new Icon(Icons.calendar_today),
              ]),
              onPressed: () async {
                final dtPick = await showDatePicker(
                    context: context,
                    initialDate: new DateTime.now(),
                    firstDate: new DateTime(1900),
                    lastDate: new DateTime(2100));
                if (dtPick != null && dtPick != _data) {
                  setState(() {
                    _data = dtPick;
                  });
                }
              },
            ),
            CustomTextFormField.textFormField(
                controller: _controllerCpf,
                label: "CPF",
                keyboard: TextInputType.number),
            CustomTextFormField.textformCepField(
                controller: _controllerCep, label: "CEP"),
            CustomTextFormField.textFormField(
                controller: _controllerEmail,
                label: "E-mail",
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
              onPressed: () async {
                String dataNasc = _data.day.toString() +
                    '/' +
                    _data.month.toString() +
                    '/' +
                    _data.year.toString();
                if (CPF.isValid(CPF.format(_controllerCpf.text.toString()))) {
                  final bool emailValido =
                      EmailValidator.validate(_controllerEmail.text.toString());
                  if (emailValido) {
                    if (_controllerSenha.text.toString() ==
                        _controllerConfirmeSenha.text.toString()) {
                      bool testCPF = await StateMachine.buscarCPF(
                          _controllerCpf.text.toString());
                      if (!testCPF) {
                        bool testEmail = await StateMachine.buscarEmail(
                            _controllerEmail.text.toString());
                        if (!testEmail) {
                          StateMachine.registerUser(
                              _controllerNome.text.toString(),
                              _controllerSobrenome.text.toString(),
                              dataNasc.toString(), // arrumar variavel data
                              _controllerCpf.text.toString(),
                              _controllerCep.text
                                  .toString()
                                  .replaceAll(RegExp('-'), ''),
                              _controllerEmail.text.toString(),
                              _controllerSenha.text.toString());
                          Flushbar(
                            message: "Cadastro realizado com sucesso",
                            icon: Icon(
                              Icons.flag,
                              size: 28.0,
                              color: Colors.blue[400],
                            ),
                            duration: Duration(seconds: 5),
                            leftBarIndicatorColor: Colors.red,
                          )..show(context);
                        } else {
                          Flushbar(
                            message: "Email já cadastrado",
                            icon: Icon(
                              Icons.info_outline,
                              size: 28.0,
                              color: Colors.red,
                            ),
                            duration: Duration(seconds: 5),
                            leftBarIndicatorColor: Colors.red,
                          )..show(context);
                        }
                      } else {
                        Flushbar(
                          message: "CPF já cadastrado",
                          icon: Icon(
                            Icons.info_outline,
                            size: 28.0,
                            color: Colors.red,
                          ),
                          duration: Duration(seconds: 5),
                          leftBarIndicatorColor: Colors.red,
                        )..show(context);
                      }
                    } else {
                      Flushbar(
                        message: "A senha não confere.",
                        icon: Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: Colors.red,
                        ),
                        duration: Duration(seconds: 5),
                        leftBarIndicatorColor: Colors.red,
                      )..show(context);
                    }
                  } else {
                    Flushbar(
                      message: "Email Invalido",
                      icon: Icon(
                        Icons.info_outline,
                        size: 28.0,
                        color: Colors.red,
                      ),
                      duration: Duration(seconds: 5),
                      leftBarIndicatorColor: Colors.red,
                    )..show(context);
                  }
                } else {
                  Flushbar(
                    message: "Este CPF é inválido.",
                    icon: Icon(
                      Icons.info_outline,
                      size: 28.0,
                      color: Colors.red,
                    ),
                    duration: Duration(seconds: 5),
                    leftBarIndicatorColor: Colors.red,
                  )..show(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
