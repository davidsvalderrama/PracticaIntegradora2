import 'package:flutter/material.dart';
import 'package:practica_dos/models/apunte.dart';

class ApuntesDetail extends StatefulWidget {
  final Apunte apunte;
  ApuntesDetail({Key key, @required this.apunte}) : super(key: key);

  @override
  _ApuntesDetailState createState() => _ApuntesDetailState();
}

class _ApuntesDetailState extends State<ApuntesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.apunte.materia}"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.grey,
            margin: EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(38, 0, 0, 0),
                  child: Image.network(
                    "${widget.apunte.imageUrl}",
                    width: 300,
                    height: 280,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "Descripcion: ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child: Text(
                    "${widget.apunte.descripcion}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "Materia: ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child: Text(
                    "${widget.apunte.materia}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
