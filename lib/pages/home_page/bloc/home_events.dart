import '/commons/entities/disco.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeDatiEvent extends HomeEvent {
  final List<Disco>? lista;
  final bool? filtroAttivo;
  final String? ordering;
  const HomeDatiEvent({
    this.lista,
    this.filtroAttivo,
    this.ordering,
  });
}

class HomeCreateDatiEvent extends HomeEvent {
  final Disco? disco;
  const HomeCreateDatiEvent({
    this.disco,
  });
}

class HomeUpdateDatiEvent extends HomeEvent {
  final Disco? disco;
  const HomeUpdateDatiEvent({
    this.disco,
  });
}
