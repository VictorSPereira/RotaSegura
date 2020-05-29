
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rotasegura/views/home.dart';
import 'package:rotasegura/widgets/CustomTextFormField.dart';
import 'package:rotasegura/globals.dart' as globals;

class NovaOcorrencia extends StatefulWidget {
  Address address;
  LatLng coordinates;
  NovaOcorrencia({Key key,@required this.address, @required this.coordinates}): super (key: key);


  @override
  _NovaOcorrenciaState createState() => _NovaOcorrenciaState();
}

class _NovaOcorrenciaState extends State<NovaOcorrencia> {
  final GlobalKey<FormState> _keyformNovaOcorrencia = GlobalKey<FormState>();
  TextEditingController _dataOcorrencia;
  TextEditingController _controllerCep;
  TextEditingController _controllerEndereco;
  TextEditingController _controllerNum;
  TextEditingController _controllerComplemento;
  TextEditingController _controllerTipo;
  TextEditingController _controllerDescricao;

  @override
  void initState() {
    super.initState();
    _controllerCep = TextEditingController();
    _controllerEndereco = TextEditingController();
    _controllerNum = TextEditingController();
    _controllerComplemento = TextEditingController();
    _controllerTipo = TextEditingController();
    _controllerDescricao = TextEditingController();
    _dataOcorrencia = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: card(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Nova Ocorrência"),
    );
  }

  Widget card() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SingleChildScrollView(
        child: _formNovaOcorrencia(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange.withOpacity(0.1),
      ),
    );
  }

  Widget _formNovaOcorrencia() {
    _controllerCep.text = widget.address?.postalCode == null? "": widget.address.postalCode;
    _controllerEndereco.text = widget.address?.thoroughfare == null? "": widget.address.thoroughfare;
    _controllerNum.text = widget.address?.subThoroughfare == null? "": widget.address.subThoroughfare;
    
    return Form(
      key: _keyformNovaOcorrencia,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: <Widget>[
            CustomTextFormField.textFormDataField(
              context,
              controller: _dataOcorrencia,
              label: "Data da Ocorrência",
            ),
            CustomTextFormField.textformCepField(controller: _controllerCep),
            CustomTextFormField.textFormField(
              controller: _controllerEndereco,
              label: "Endereço",
            ),
            CustomTextFormField.textFormField(
              controller: _controllerNum,
              label: "Nº",
            ),
            CustomTextFormField.textFormField(
              controller: _controllerComplemento,
              label: "Complemento",
            ),
            CustomTextFormField.textFormDropField(
                controller: _controllerTipo,
                label: "Tipo",
                icon: Icon(Icons.arrow_drop_down_circle)),
            textArea(
              controller: _controllerDescricao,
              label: "Descrição",
            ),
            buttonSalvar()
          ],
        ),
      ),
    );
  }

  Widget buttonSalvar() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      child: Text(
        "salvar",
        style: TextStyle(fontSize: 14),
      ),
      color: Colors.green,
      onPressed: () {
        _onAddMarkerButtonPressed();
        Navigator.of(context).pop();
      },
    );
  }
addToGlobals() async {
  var res = await Geocoder.local.findAddressesFromCoordinates(Coordinates(widget.coordinates.latitude, widget.coordinates.longitude));
  globals.address.add(res.first);


  globals.points.add(Marker(
      markerId: MarkerId(widget
          .coordinates.toString()),
      position: widget.coordinates,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
          title: _controllerTipo.text,
          snippet: _controllerDescricao.text
      )

  ));
}
  void _onAddMarkerButtonPressed() {
    setState((){
    addToGlobals();
    });
  }

  Widget textArea({TextEditingController controller, String label}) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      reverse: true,
      child: TextFormField(
        maxLength: 256,
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

