import 'package:disco_teca/commons/data/helpers/data_helpers.dart';
import 'package:disco_teca/commons/entities/disco.dart';
import 'package:disco_teca/commons/service/storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/pages/filtro_dischi/bloc/filtro_dischi_events.dart';
import '/pages/filtro_dischi/bloc/filtro_dischi_states.dart';

class FiltroDischiBloc extends Bloc<FiltroDischiEvent, FiltroDischiState> {
  FiltroDischiBloc() : super(FiltroDischiLoadingState()) {
    on<FiltroDischiInitEvent>(_onInitialize);
    on<UpdatePosizioneEvent>(_onUpdatePosizione);
    on<UpdateGiriEvent>(_onUpdateGiri);
  }

  void _onInitialize(
    FiltroDischiInitEvent event,
    Emitter<FiltroDischiState> emit,
  ) async {
    final serviceStorage = await StorageService().init();

    List<Disco> listaDischi = await serviceStorage.estraiListaDischi();

    List<String> listaPosizioni =
        DataHelpers().estraiListaPosizioniDischi(listaDischi);
    emit(
      state.copyWith(
        listaPosizioni: listaPosizioni,
      ),
    );
  }

  void _onUpdatePosizione(
    UpdatePosizioneEvent event,
    Emitter<FiltroDischiState> emit,
  ) async {
    emit(
      state.copyWith(posizione: event.posizione),
    );
  }

  void _onUpdateGiri(
    UpdateGiriEvent event,
    Emitter<FiltroDischiState> emit,
  ) async {
    emit(
      state.copyWith(giri: event.giri),
    );
  }
}
