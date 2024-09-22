import '/commons/entities/disco.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeInitDatiEvent extends HomeEvent {
  final List<Disco>? lista;
  final bool? filtroAttivo;
  final String? ordering;
  const HomeInitDatiEvent({
    this.lista,
    this.filtroAttivo,
    this.ordering,
  });
}

class HomeUpdateDatiEvent extends HomeEvent {
  final List<Disco>? lista;
  final bool? filtroAttivo;
  final String? ordering;
  const HomeUpdateDatiEvent({
    this.lista,
    this.filtroAttivo,
    this.ordering,
  });
}

class HomeCreateDatoEvent extends HomeEvent {
  final Disco? disco;
  const HomeCreateDatoEvent({
    this.disco,
  });
}

class HomeUpdateDatoEvent extends HomeEvent {
  final Disco? disco;
  const HomeUpdateDatoEvent({
    this.disco,
  });
}
