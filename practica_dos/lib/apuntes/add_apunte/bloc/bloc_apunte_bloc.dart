import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

part 'bloc_apunte_event.dart';
part 'bloc_apunte_state.dart';

class BlocApunteBloc extends Bloc<BlocApunteEvent, BlocApunteState> {
  File _choosenImage;
  String _url;

  @override
  BlocApunteState get initialState => BlocApunteInitial();

  @override
  Stream<BlocApunteState> mapEventToState(
    BlocApunteEvent event,
  ) async* {
    if (event is EscogerImagenEvent) {
      bool temp = await _chooseImage();
      if (temp) {
        yield EscogerImagen(imgtmp: _choosenImage);
      } else {
        yield EscogerImagenError(errorMessage: "Carga otra imagen");
      }
    } else if (event is SubirImagenEvent) {
      bool temp2 = await _uploadFile();
      if (temp2) {
        yield SubirImagen(img: _url);
      } else {
        yield SubirImagenError(errorMessage: "No se pudo subir la imagen");
      }
    } else if (event is InitialEvent){
      yield BlocApunteInitial();
    }
  }

  Future<bool> _chooseImage() async {
    try {
      await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 720,
        maxWidth: 720,
      ).then((image) {
        _choosenImage = image;
      });
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<bool> _uploadFile() async {
    try {
      String filePath = _choosenImage.path;
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child("apuntes/${Path.basename(filePath)}");
      StorageUploadTask uploadTask = reference.putFile(_choosenImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        print("Link>>>>> $imageUrl");
      });
      await reference.getDownloadURL().then((fileURL) {
        print("$fileURL");
        _url = fileURL;
      });
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
