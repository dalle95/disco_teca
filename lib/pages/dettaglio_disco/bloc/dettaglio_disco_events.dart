import 'package:disco_teca/commons/entities/disco.dart';

abstract class DettaglioDiscoEvent {}

class LoadingEvent extends DettaglioDiscoEvent {
  LoadingEvent();
}

class InitializeEvent extends DettaglioDiscoEvent {
  final Disco disco;
  InitializeEvent({required this.disco});
}

class UpdateEvent extends DettaglioDiscoEvent {
  final Disco disco;
  UpdateEvent({required this.disco});
}

class UpdateFieldEvent extends DettaglioDiscoEvent {
  final String field;
  final String value;
  UpdateFieldEvent({
    required this.field,
    required this.value,
  });
}

class UpdateTipologiaEvent extends DettaglioDiscoEvent {
  final String tipologia;
  UpdateTipologiaEvent({required this.tipologia});
}

class MostraLatoEvent extends DettaglioDiscoEvent {
  final String lato;
  MostraLatoEvent({required this.lato});
}

class CambiaSetPosizioneEvent extends DettaglioDiscoEvent {
  CambiaSetPosizioneEvent();
}
