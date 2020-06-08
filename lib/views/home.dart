import 'dart:async';
//import 'dart:html';
import 'package:bubble/bubble.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rotasegura/custom/social_icons.dart';
import 'package:rotasegura/helpers/stateMachine.dart';
import 'package:rotasegura/views/SuasContribuicoes.dart';
import 'package:rotasegura/views/Configuracoes.dart';
import 'package:rotasegura/views/locaisInteresse.dart';
import 'package:rotasegura/views/indicadores.dart';
import 'package:rotasegura/views/opcoesCadastroUsuario.dart';
import 'package:rotasegura/views/novaOcorrencia.dart';
import 'package:rotasegura/views/perfil.dart';
import 'package:rotasegura/widgets/CustomItemListDelito.dart';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:geocoder/geocoder.dart';
import 'package:rotasegura/globals.dart' as globals;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _customScaffoldState;
  GlobalKey<FormState> _globalKeyformCadastro;

  TextEditingController _controllerUsuario;
  TextEditingController _controllerSenha;
  TextEditingController _controllerSearch;

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  bool _lista = false;
  bool _logado = false;
  bool isLoading = false;
  String nomeUser = "Usuario";
  String errorMessage;

  static const LatLng _center = const LatLng(-22.8822874, -47.0564147);
  LatLng _lastMapPosition = _center;
  Address _lastMapAddress;
  static const kGoogleApiKey = "AIzaSyDW_Ui1WD1Af6M9vmtHOQhHxr0Tb4idhnw";

  @override
  void initState() {
    super.initState();
    _customScaffoldState = GlobalKey<ScaffoldState>();
    _globalKeyformCadastro = GlobalKey<FormState>();

    _controllerUsuario = TextEditingController();
    _controllerSenha = TextEditingController();

    _lastMapPosition = LatLng(-22.8822874, -47.0564147);
    StateMachine.connectDB();
    //_handleTap(_lastMapPosition);
  }

  @override
  Widget build(BuildContext context) {
    _controllerUsuario = new TextEditingController();
    _controllerSenha = new TextEditingController();
    return Scaffold(
      key: _customScaffoldState,
      body: _body(),
      drawer: drawerMenu(),
      floatingActionButton: !_lista
          ? _logado
              ? FloatingActionButton(
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    navigatorTo(
                        context: context,
                        to: NovaOcorrencia(
                          address: _lastMapAddress,
                          coordinates: _lastMapPosition,
                        ));
                    _maps();
                  },
                  tooltip: 'Adicionar Delito',
                  child: const Icon(Icons.add),
                )
              : null
          : null,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    _controller.complete(controller);
  }

  Widget _maps() {
    print("MAPOUUUUUUUUUU!");
    return SingleChildScrollView(
        child: Container(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        mapToolbarEnabled: true,
        markers: globals.points,
        onCameraMove: _onCameraMove,
        onTap: _handleTap,
      ),
      height: MediaQuery.of(context).size.height,
    ));
  }

  Future _handleTap(LatLng point) async {
    setState(() {
      _lastMapPosition = point;
    });
    StateMachine.selectDB();
    var res = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(_lastMapPosition.latitude, _lastMapPosition.longitude));
    _lastMapAddress = res.first;
  }

  _onCameraMove(CameraPosition position) async {
    _lastMapPosition = position.target;
    var res = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(_lastMapPosition.latitude, _lastMapPosition.longitude));
    _lastMapAddress = res.first;
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        _maps(),
        SafeArea(
          child: Column(children: <Widget>[
            _appBar(),
            _lista
                ? Expanded(
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 5, right: 5, top: 15),
                      child: _listDelito(),
                    ),
                  )
                : SizedBox(),
          ]),
        ),
      ],
    );
  }

  void openDrawer() {
    if (_customScaffoldState.currentState != null &&
        _customScaffoldState.currentState.isEndDrawerOpen)
      _customScaffoldState.currentState.openEndDrawer();
    _customScaffoldState.currentState?.openDrawer();
  }

  Widget drawerMenu() {
    return Drawer(child: _logado ? drawerMenuPrincipal() : drawerLogin());
  }

  Widget drawerLogin() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Image.asset(
                "assets/logo/RS_logo_2.png",
                width: 250,
              ),
            ),
          ),
          Form(
            key: _globalKeyformCadastro,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  textFormField(
                      controller: _controllerUsuario,
                      label: "Usuário",
                      icon: Icons.person_pin,
                      keyboardtype: TextInputType.emailAddress),
                  SizedBox(height: 25),
                  textFormField(
                      controller: _controllerSenha,
                      label: "Senha",
                      icon: Icons.lock,
                      obscureText: true),
                  SizedBox(height: 50),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0)),
                      color: Colors.orange,
                      child: Text("Entrar"),
                      onPressed: () async {
                        if (_controllerUsuario.text.toString() != null &&
                            _controllerSenha.text.toString() != null) {
                          globals.idUser = await StateMachine.loginRota(
                              _controllerUsuario.text.toString(),
                              _controllerSenha.text.toString());
                          print("id do usuario" +globals.idUser.toString());
                          if (globals.idUser != null &&globals.idUser > 1) {
                            setState(() {
                              _logado = true;
                            });
                          }
                          if (globals.idUser == null ||globals.idUser == 0) {
                            Flushbar(
                              message: "Usuario ou senha invalido!!!",
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
                            message: "Insira o email e senha !",
                            icon: Icon(
                              Icons.alternate_email,
                              size: 28.0,
                              color: Colors.red,
                            ),
                            duration: Duration(seconds: 5),
                            leftBarIndicatorColor: Colors.red,
                          )..show(context);
                        }
                      }),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0)),
                    icon: Icon(Social.facebook),
                    color: Colors.blue,
                    label: Text('Facebook'),
                    onPressed: () {
                      setState(() {
                         _logado = true;
                      });
                    },
                  ),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0)),
                    icon: Icon(Social.twitter),
                    color: Colors.green,
                    label: Text('Twitter'),
                    onPressed: () {
                      setState(() {
                        // _logado = true;
                      });
                    },
                  ),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0)),
                    icon: Icon(Social.google),
                    color: Colors.redAccent,
                    label: Text('Google'),
                    onPressed: () {
                      setState(() {
                        _logado = true;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.black54, height: 20, endIndent: 15, indent: 15),
          Container(
            height: 100,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.orange, fontSize: 15),
                  ),
                  onPressed: () {
                    navigatorTo(context: context, to: OpcoesCadastroUsuario());
                  },
                ),
                FlatButton(
                  child: Text("Esqueceu sua senha ?",
                      style: TextStyle(color: Colors.orange, fontSize: 15)),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget drawerMenuPrincipal() {
    return ListView(children: <Widget>[
      DrawerHeader(
        child: Center(
          child: Image.asset(
            "assets/logo/RS_logo_3.png",
            width: 250,
          ),
        ),
      ),
      itemMenuPrincipal(
          title: "Seus lugares",
          icon: Icons.place,
          onTap: () {
            navigatorTo(context: context, to: LocaisInteresse());
          }),
      itemMenuPrincipal(
          title: "Suas Contribuições",
          icon: Icons.style,
          onTap: () {
            navigatorTo(context: context, to: SuasContribuicoes());
          }),
      itemMenuPrincipal(
          title: "Configurações",
          icon: Icons.settings,
          onTap: () {
            navigatorTo(context: context, to: Configuracoes());
          }),
      itemMenuPrincipal(
          title: "Perfil",
          icon: Icons.person,
          onTap: () {
            navigatorTo(context: context, to: Perfil());
          }),
      itemMenuPrincipal(
          title: "Indicadores",
          icon: Icons.insert_chart,
          onTap: () {
            navigatorTo(context: context, to: Indicadores());
          }),
      itemMenuPrincipal(
        title: "Sair",
        icon: Icons.exit_to_app,
        onTap: () {
          setState(() {
            _logado = false;
           globals.idUser = 0;
            Flushbar(
              message: "Tcháu ate a proxima !!",
              //
              icon: Icon(
                Icons.favorite,
                size: 28.0,
                color: Colors.red,
              ),
              duration: Duration(seconds: 5),
              leftBarIndicatorColor: Colors.orange[200],
            )..show(context);
          });
        },
      ),
    ]);
  }

  void navigatorTo({BuildContext context, Widget to}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => to));
  }

  Widget itemMenuPrincipal({String title, IconData icon, Function onTap}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
      leading: Icon(icon),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  Widget textFormField(
      {String label,
      TextEditingController controller,
      String hintText,
      IconData icon,
      TextInputType keyboardtype = TextInputType.text,
      bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardtype,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
          ),
          prefixIcon: Icon(icon, size: 30)),
    );
  }

  Widget _appBar() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buttonsMapList(),
          SizedBox(height: 10),
          _barSearch(),
        ],
      ),
    );
  }

  Widget _buttonsMapList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 25,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            color: _lista == true ? Colors.white : Colors.orange,
          ),
          child: Center(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _lista = false;
                });
              },
              child: Text("Mapa"),
            ),
          ),
        ),
        Container(
          height: 25,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: _lista == false ? Colors.white : Colors.orange,
          ),
          child: Center(
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _lista = true;
                });
              },
              child: Text("Lista"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _barSearch() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.5),
                blurRadius: 5.0,
                offset: Offset(3.0, 3.0))
          ]),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: openDrawer,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.menu,
                size: 25,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  border: InputBorder.none,
                  hintText: "Digite endereço ou cep"),
            ),
          ),
        ],
      ),
    );
  }

  _search(String string) async {
    /* var t = await Geocoder.local.findAddressesFromQuery(string);
    print(string);
    print(t.first.coordinates);
    LatLng center = LatLng(t.first.coordinates.latitude, t.first.coordinates.longitude);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));*/
    //_handlePressButton();
  }
  Widget _listDelito() {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 64.0, 0.0),
      leading: CircleAvatar(child: Text("teste")),
      title: Text("teste", textAlign: TextAlign.left),
      subtitle: Text("teste", textAlign: TextAlign.left),
    );
  }

  Widget slidableBuild(BuildContext context, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      closeOnScroll: true,
      actionExtentRatio: 0.20,
      child: CustomListItemDelito(
        index: index,
      ).build(context),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Compartilhar',
          color: Colors.red,
          icon: Icons.share,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Favoritar',
          color: Colors.yellow,
          icon: Icons.star_border,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Agradecer',
          color: Colors.purple,
          icon: Icons.thumb_up,
          onTap: () {},
        ),
      ],
    );
  }
}
