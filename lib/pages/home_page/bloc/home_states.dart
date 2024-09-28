import 'package:logger/logger.dart';

import '/commons/entities/disco.dart';

class HomeState {
  const HomeState({
    this.lista = const [],
    this.filtroAttivo = false,
    this.filtroStrutturatoAttivo = false,
    this.filtroStrutturato,
    this.ordering,
  });

  final List<Disco> lista;
  final bool filtroAttivo;
  final bool filtroStrutturatoAttivo;
  final Map<String, String>? filtroStrutturato;
  final String? ordering;

  HomeState copyWith({
    List<Disco>? lista,
    bool? filtroAttivo,
    bool? filtroStrutturatoAttivo,
    Map<String, String>? filtroStrutturato,
    String? ordering,
  }) {
    Logger().d(
        "N° di dischi: ${lista?.length.toString() ?? this.lista.length.toString()}");
    return HomeState(
      lista: lista ?? this.lista,
      filtroAttivo: filtroAttivo ?? this.filtroAttivo,
      filtroStrutturatoAttivo:
          filtroStrutturatoAttivo ?? this.filtroStrutturatoAttivo,
      filtroStrutturato: filtroStrutturato ?? this.filtroStrutturato,
      ordering: ordering ?? this.ordering,
    );
  }
}

class HomeLoadingState extends HomeState {
  final List<Disco> lista;
  final bool filtroAttivo;
  final bool filtroStrutturatoAttivo;
  final String? ordering;
  HomeLoadingState({
    this.lista = const [],
    this.filtroAttivo = false,
    this.filtroStrutturatoAttivo = false,
    this.ordering,
  });
}
