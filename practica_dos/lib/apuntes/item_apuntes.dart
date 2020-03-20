import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/apuntes/apuntes_detail.dart';
import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';
import 'package:practica_dos/models/apunte.dart';

class ItemApuntes extends StatefulWidget {
  final String imageUrl;
  final String materia;
  final String descripcion;
  final int index;
  ItemApuntes({
    Key key,
    @required this.imageUrl,
    @required this.index,
    @required this.materia,
    @required this.descripcion,
  }) : super(key: key);

  @override
  _ItemApuntesState createState() => _ItemApuntesState();
}

class _ItemApuntesState extends State<ItemApuntes> {

  void _delete() {
    BlocProvider.of<ApuntesBloc>(context).add(
      RemoveDataEvent(index: widget.index),
    );
  }

  void _detail(Apunte ap){
     Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ApuntesDetail(apunte: ap))
    );
  }

   _dialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "¡Eliminar Item!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text("¿Estas seguro?"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new FlatButton(
                  child: new Text("ACEPTAR"),
                  onPressed: () {
                    _delete();
                    Navigator.of(context).pop();
                  },
                ),
                 new FlatButton(
              child: new Text("CANCELAR"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
              ],
            ),
            
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Apunte ap = Apunte(materia: widget.materia, descripcion: widget.descripcion, imageUrl: widget.imageUrl);
        _detail(ap);
      },
          child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _dialog();
                  },
                )
              ],
            ),
            Image.network(
              widget.imageUrl ?? "https://via.placeholder.com/150",
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            Container(
              child: Text(
                "${widget.materia}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Text("${widget.descripcion}"),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
