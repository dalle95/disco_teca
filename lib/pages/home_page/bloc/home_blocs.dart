import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/commons/data/api/dischi_api.dart';
import '/commons/entities/disco.dart';

import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          HomeLoadingState(
            ordering: 'Artista',
          ),
        ) {
    on<HomeInitDatiEvent>(_initDatiEvent);
    on<HomeUpdateDatiEvent>(_updateDatiEvent);
    on<HomeUpdateDatoEvent>(_aggiornaDiscoEvent);
    on<HomeCreateDatoEvent>(_creaDiscoEvent);
  }

  void _initDatiEvent(
    HomeInitDatiEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      HomeLoadingState(
        lista: state.lista,
        ordering: state.ordering,
      ),
    );

    List<Disco> lista = [];

    // Funzione di estrazione dati dei clienti
    lista = await DiscoApi().estraiDati();

    emit(
      state.copyWith(
        lista: lista,
        ordering: state.ordering,
      ),
    );
  }

  void _updateDatiEvent(
    HomeUpdateDatiEvent event,
    Emitter<HomeState> emit,
  ) async {
    Logger().d(
        'Lista: ${event.lista.toString()}, Filtro: ${event.filtroStrutturatoAttivo}');
    emit(
      state.copyWith(
        lista: event.lista,
        filtroAttivo: event.filtroAttivo,
        filtroStrutturatoAttivo: event.filtroStrutturatoAttivo,
        filtroStrutturato: event.filtroStrutturato,
        ordering: event.ordering,
      ),
    );
  }

  void _aggiornaDiscoEvent(
    HomeUpdateDatoEvent event,
    Emitter<HomeState> emit,
  ) {
    List<Disco> lista = List.from(state.lista);
    Disco? discoAggiornato = event.disco!;

    // Controllo la lista e aggiorno quello modificato
    for (int i = 0; i < lista.length; i++) {
      if (lista[i].id == discoAggiornato.id) {
        lista[i] = discoAggiornato;
        break;
      }
    }

    Logger().d(lista.length);
    emit(
      state.copyWith(
        lista: lista,
      ),
    );
  }

  void _creaDiscoEvent(
    HomeCreateDatoEvent event,
    Emitter<HomeState> emit,
  ) {
    List<Disco> lista = List.from(state.lista);
    Disco? clienteCreato = event.disco!;

    lista.add(clienteCreato);

    lista.sort(
      (a, b) => a.titoloAlbum!.compareTo(b.titoloAlbum!),
    );

    emit(
      state.copyWith(
        lista: lista,
      ),
    );
  }
}
