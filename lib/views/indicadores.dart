import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicadores extends StatefulWidget {
  @override
  _IndicadoresState createState() => _IndicadoresState();
}

class _IndicadoresState extends State<Indicadores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Indicadores"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: _buildListInteresses(),
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

  Widget _buildListInteresses() {
    return ListView(children: <Widget>[
      Center(
          child: Text(
        'Campinas',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
      )),
      DataTable(
        columns: [
          DataColumn(label: Text('Bairro')),
          DataColumn(label: Text('Assalto')),
          DataColumn(label: Text('A/morte')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('Barão Geraldo')),
            DataCell(Text('4')),
            DataCell(Text('0')),
          ]),
          DataRow(cells: [
            DataCell(Text('Taquaral')),
            DataCell(Text('15')),
            DataCell(Text('1')),
          ]),
          DataRow(cells: [
            DataCell(Text('Vila União')),
            DataCell(Text('12')),
            DataCell(Text('2')),
          ]),
        ],
      ),
    ]);
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
}
