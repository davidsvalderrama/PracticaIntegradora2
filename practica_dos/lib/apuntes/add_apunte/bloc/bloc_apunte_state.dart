part of 'bloc_apunte_bloc.dart';

abstract class BlocApunteState extends Equatable {
  const BlocApunteState();
}

class BlocApunteInitial extends BlocApunteState {
  @override
  List<Object> get props => [];
}

class EscogerImagen extends BlocApunteState {
  final File imgtmp;
  EscogerImagen({
    @required this.imgtmp
  });
  @override
  List<Object> get props => [imgtmp];
}

class EscogerImagenError extends BlocApunteState {
  final String errorMessage;

  EscogerImagenError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class SubirImagen extends BlocApunteState {
  final dynamic img;
  SubirImagen({
    @required this.img
  });
  @override
  List<Object> get props => [img];
}

class SubirImagenError extends BlocApunteState {
  final String errorMessage;
  SubirImagenError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
