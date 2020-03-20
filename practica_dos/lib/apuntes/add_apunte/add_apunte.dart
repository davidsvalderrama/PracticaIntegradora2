import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/apuntes/add_apunte/bloc/bloc_apunte_bloc.dart';
import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';

class AddApunte extends StatefulWidget {
  AddApunte({Key key}) : super(key: key);

  @override
  _AddApunteState createState() => _AddApunteState();
}

class _AddApunteState extends State<AddApunte> {
  File _choosenImage;
  String _url;
  bool _isLoading = false;
  TextEditingController _materiaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  BlocApunteBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar apunte")),
      body: BlocProvider(
        create: (context) {
          bloc = BlocApunteBloc()..add(InitialEvent());
          return bloc;
        },
        child: BlocListener<BlocApunteBloc, BlocApunteState>(
          listener: (context, state) {
            if (state is EscogerImagenError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("No se carga la imagen"),
                  ),
                );
            }
            if (state is SubirImagenError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("No se puedo subir la imagen"),
                  ),
                );
            }
          },
          child: BlocBuilder<BlocApunteBloc, BlocApunteState>(
            builder: (context, state) {
              if (state is EscogerImagen) {
                _choosenImage = state.imgtmp;
              }
              if (state is SubirImagen) {
                _url = state.img;
                _saveData();
              }
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: FractionalOffset.center,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _choosenImage != null
                              ? Image.file(
                                  _choosenImage,
                                  width: 150,
                                  height: 150,
                                )
                              : Container(
                                  height: 150,
                                  width: 150,
                                  child: Placeholder(
                                    fallbackHeight: 150,
                                    fallbackWidth: 150,
                                  ),
                                ),
                          SizedBox(height: 48),
                          IconButton(
                            icon: Icon(Icons.image),
                            onPressed: () {
                              bloc.add(EscogerImagenEvent());
                            },
                          ),
                          SizedBox(height: 48),
                          TextField(
                            controller: _materiaController,
                            decoration: InputDecoration(
                              hintText: "Nombre de la materia",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            controller: _descripcionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Notas para el examen...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  child: Text("Guardar"),
                                  onPressed: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    bloc.add(
                                        SubirImagenEvent(img: _choosenImage));
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      _isLoading ? CircularProgressIndicator() : Container(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _saveData() {
    BlocProvider.of<ApuntesBloc>(context).add(
      SaveDataEvent(
        materia: _materiaController.text,
        descripcion: _descripcionController.text,
        imageUrl: _url,
      ),
    );
    _isLoading = false;
    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      Navigator.of(context).pop();
    });
    
  }
}
