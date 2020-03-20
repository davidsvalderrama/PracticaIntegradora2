part of 'bloc_apunte_bloc.dart';

abstract class BlocApunteEvent extends Equatable {
  const BlocApunteEvent();
}

class InitialEvent extends BlocApunteEvent{
  @override

  List<Object> get props => [];
}

class EscogerImagenEvent extends BlocApunteEvent {
  
  @override
  List<Object> get props => [];
}

class SubirImagenEvent extends BlocApunteEvent {
  final File img;
  
  SubirImagenEvent(
      {@required this.img});

  @override
  List<Object> get props => [img];
}




