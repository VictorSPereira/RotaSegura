import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SuasContribuicoes extends StatefulWidget {
  @override
  _SuasContribuicoesState createState() => _SuasContribuicoesState();
}

class _SuasContribuicoesState extends State<SuasContribuicoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suas contribuições"),
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
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.transparent,),
      itemBuilder: slidableBuild,
      itemCount: 2,
      scrollDirection: Axis.vertical,
    );
  }

  Widget _buildItemListInterresse() {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10, right: 10),
        leading: Icon(
          Icons.location_on,
          size: 40,
        ),
        title: Text('Casa'),
        subtitle: Text('Rua luiz augusto souza, campinas - SP - 13107-225'),
        );
  }

  Widget _buildRodape() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset("assets/logo/RS_logo_3.png", width: 150,),
      ),
    );
  }

  Widget slidableBuild(BuildContext context, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      closeOnScroll: true,
      actionExtentRatio: 0.20,
      child: _buildItemListInterresse(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Editar',
          color: Colors.yellow,
          icon: Icons.edit,
          onTap: () {},
        ),        
      ],
    );
  }
}
