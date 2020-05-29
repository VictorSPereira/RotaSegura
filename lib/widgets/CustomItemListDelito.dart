import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rotasegura/globals.dart' as globals;

class CustomListItemDelito extends StatelessWidget {

  final int index;

  const CustomListItemDelito({Key key, this.index}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,      
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.5),
                blurRadius: 5.0,
                offset: Offset(3.0, 3.0))
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_indicator(), _bodyDescription()],
      ),
    );
  }

  Widget _bodyDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10, 2.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    globals.points.elementAt(index).infoWindow.title.toString()??"",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                  Text(
                    globals.address.elementAt(index).thoroughfare,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Comentários(10)",
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Agradecimentos(10)",
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _indicator() {
    return AspectRatio(
      aspectRatio: .5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
          ),
        ),
      ),
    );
  }
}
