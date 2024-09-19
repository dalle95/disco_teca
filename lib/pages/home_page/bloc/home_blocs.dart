import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/entities/disco.dart';

import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          const HomeState(
            ordering: 'Titolo',
          ),
        ) {
    on<HomeDatiEvent>(_datiEvent);
    on<HomeUpdateDatiEvent>(_aggiornaClienteEvent);
    on<HomeCreateDatiEvent>(_creaClienteEvent);
  }

  void _datiEvent(HomeDatiEvent event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        lista: event.lista,
        filtroAttivo: event.filtroAttivo,
        ordering: event.ordering,
      ),
    );
  }

  void _aggiornaClienteEvent(
    HomeUpdateDatiEvent event,
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
    emit(
      state.copyWith(
        lista: lista,
      ),
    );
  }

  void _creaClienteEvent(
    HomeCreateDatiEvent event,
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
