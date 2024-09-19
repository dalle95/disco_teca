import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/pages/dettaglio_disco/bloc/dettaglio_disco_events.dart';
import '/pages/dettaglio_disco/bloc/dettaglio_disco_states.dart';

class DettaglioDiscoBloc
    extends Bloc<DettaglioDiscoEvent, DettaglioDiscoState> {
  DettaglioDiscoBloc() : super(DettaglioDiscoState.initial()) {
    on<InitializeEvent>(_onInitialize);
    on<UpdateFieldEvent>(_onUpdateField);
    on<MostraLatoEvent>(_onMostraLato);
    on<UpdateTipologiaEvent>(_onUpdateTipologia);
  }

  void _onInitialize(
    InitializeEvent event,
    Emitter<DettaglioDiscoState> emit,
  ) {
    emit(
      state.copyWith(
        tipologia: event.disco.giri,
        disco: event.disco,
        lato: 'A',
        artistaController: TextEditingController(text: event.disco.artista),
        posizioneController: TextEditingController(text: event.disco.posizione),
        titoloAlbumController:
            TextEditingController(text: event.disco.titoloAlbum),
        annoController: TextEditingController(text: event.disco.anno),
        valoreController: TextEditingController(
            text: event.disco.valore == 0 ? '' : event.disco.valore.toString()),
        brano1AController: TextEditingController(text: event.disco.brano1A),
        brano2AController: TextEditingController(text: event.disco.brano2A),
        brano3AController: TextEditingController(text: event.disco.brano3A),
        brano4AController: TextEditingController(text: event.disco.brano4A),
        brano5AController: TextEditingController(text: event.disco.brano5A),
        brano6AController: TextEditingController(text: event.disco.brano6A),
        brano7AController: TextEditingController(text: event.disco.brano7A),
        brano8AController: TextEditingController(text: event.disco.brano8A),
        brano1BController: TextEditingController(text: event.disco.brano1B),
        brano2BController: TextEditingController(text: event.disco.brano2B),
        brano3BController: TextEditingController(text: event.disco.brano3B),
        brano4BController: TextEditingController(text: event.disco.brano4B),
        brano5BController: TextEditingController(text: event.disco.brano5B),
        brano6BController: TextEditingController(text: event.disco.brano6B),
        brano7BController: TextEditingController(text: event.disco.brano7B),
        brano8BController: TextEditingController(text: event.disco.brano8B),
      ),
    );
  }

  void _onUpdateField(
      UpdateFieldEvent event, Emitter<DettaglioDiscoState> emit) {
    final updatedDisco = state.disco.copyWith(
      autore: event.field == 'artista' ? event.value : state.disco.artista,
      posizione:
          event.field == 'posizione' ? event.value : state.disco.posizione,
      titoloAlbum:
          event.field == 'titoloAlbum' ? event.value : state.disco.titoloAlbum,
      anno: event.field == 'anno' ? event.value : state.disco.anno,
      valore: event.field == 'valore'
          ? double.tryParse(event.value)
          : state.disco.valore,
      brano1A: event.field == 'brano1A' ? event.value : state.disco.brano1A,
      brano2A: event.field == 'brano2A' ? event.value : state.disco.brano2A,
      brano3A: event.field == 'brano3A' ? event.value : state.disco.brano3A,
      brano4A: event.field == 'brano4A' ? event.value : state.disco.brano4A,
      brano5A: event.field == 'brano5A' ? event.value : state.disco.brano5A,
      brano6A: event.field == 'brano6A' ? event.value : state.disco.brano6A,
      brano7A: event.field == 'brano7A' ? event.value : state.disco.brano7A,
      brano8A: event.field == 'brano8A' ? event.value : state.disco.brano8A,
      brano1B: event.field == 'brano1B' ? event.value : state.disco.brano1B,
      brano2B: event.field == 'brano2B' ? event.value : state.disco.brano2B,
      brano3B: event.field == 'brano3B' ? event.value : state.disco.brano3B,
      brano4B: event.field == 'brano4B' ? event.value : state.disco.brano4B,
      brano5B: event.field == 'brano5B' ? event.value : state.disco.brano5B,
      brano6B: event.field == 'brano6B' ? event.value : state.disco.brano6B,
      brano7B: event.field == 'brano7B' ? event.value : state.disco.brano7B,
      brano8B: event.field == 'brano8B' ? event.value : state.disco.brano8B,
    );
    emit(state.copyWith(disco: updatedDisco));
  }

  void _onUpdateTipologia(
      UpdateTipologiaEvent event, Emitter<DettaglioDiscoState> emit) {
    emit(state.copyWith(tipologia: event.tipologia));
  }

  void _onMostraLato(MostraLatoEvent event, Emitter<DettaglioDiscoState> emit) {
    emit(state.copyWith(lato: event.lato));
  }
}
