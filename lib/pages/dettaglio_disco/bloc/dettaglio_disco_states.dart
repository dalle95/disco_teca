import 'package:flutter/material.dart';

import '/commons/entities/disco.dart';

class DettaglioDiscoState {
  final Disco disco;
  final TextEditingController artistaController;
  final TextEditingController posizioneController;
  final TextEditingController ordineController;
  final TextEditingController titoloAlbumController;
  final TextEditingController annoController;
  final TextEditingController valoreController;
  final TextEditingController brano1AController;
  final TextEditingController brano2AController;
  final TextEditingController brano3AController;
  final TextEditingController brano4AController;
  final TextEditingController brano5AController;
  final TextEditingController brano6AController;
  final TextEditingController brano7AController;
  final TextEditingController brano8AController;
  final TextEditingController brano1BController;
  final TextEditingController brano2BController;
  final TextEditingController brano3BController;
  final TextEditingController brano4BController;
  final TextEditingController brano5BController;
  final TextEditingController brano6BController;
  final TextEditingController brano7BController;
  final TextEditingController brano8BController;
  final String tipologia;
  final String lato;

  DettaglioDiscoState({
    required this.disco,
    required this.artistaController,
    required this.posizioneController,
    required this.ordineController,
    required this.titoloAlbumController,
    required this.annoController,
    required this.valoreController,
    required this.brano1AController,
    required this.brano2AController,
    required this.brano3AController,
    required this.brano4AController,
    required this.brano5AController,
    required this.brano6AController,
    required this.brano7AController,
    required this.brano8AController,
    required this.brano1BController,
    required this.brano2BController,
    required this.brano3BController,
    required this.brano4BController,
    required this.brano5BController,
    required this.brano6BController,
    required this.brano7BController,
    required this.brano8BController,
    required this.tipologia,
    required this.lato,
  });

  factory DettaglioDiscoState.initial() {
    return DettaglioDiscoState(
      disco: const Disco(),
      artistaController: TextEditingController(),
      posizioneController: TextEditingController(),
      ordineController: TextEditingController(),
      titoloAlbumController: TextEditingController(),
      annoController: TextEditingController(),
      valoreController: TextEditingController(),
      brano1AController: TextEditingController(),
      brano2AController: TextEditingController(),
      brano3AController: TextEditingController(),
      brano4AController: TextEditingController(),
      brano5AController: TextEditingController(),
      brano6AController: TextEditingController(),
      brano7AController: TextEditingController(),
      brano8AController: TextEditingController(),
      brano1BController: TextEditingController(),
      brano2BController: TextEditingController(),
      brano3BController: TextEditingController(),
      brano4BController: TextEditingController(),
      brano5BController: TextEditingController(),
      brano6BController: TextEditingController(),
      brano7BController: TextEditingController(),
      brano8BController: TextEditingController(),
      tipologia: '33',
      lato: 'A',
    );
  }

  DettaglioDiscoState copyWith({
    Disco? disco,
    TextEditingController? artistaController,
    TextEditingController? posizioneController,
    TextEditingController? ordineController,
    TextEditingController? titoloAlbumController,
    TextEditingController? annoController,
    TextEditingController? valoreController,
    TextEditingController? brano1AController,
    TextEditingController? brano2AController,
    TextEditingController? brano3AController,
    TextEditingController? brano4AController,
    TextEditingController? brano5AController,
    TextEditingController? brano6AController,
    TextEditingController? brano7AController,
    TextEditingController? brano8AController,
    TextEditingController? brano1BController,
    TextEditingController? brano2BController,
    TextEditingController? brano3BController,
    TextEditingController? brano4BController,
    TextEditingController? brano5BController,
    TextEditingController? brano6BController,
    TextEditingController? brano7BController,
    TextEditingController? brano8BController,
    String? tipologia,
    String? lato,
  }) {
    return DettaglioDiscoState(
      disco: disco ?? this.disco,
      artistaController: artistaController ?? this.artistaController,
      posizioneController: posizioneController ?? this.posizioneController,
      ordineController: ordineController ?? this.ordineController,
      titoloAlbumController:
          titoloAlbumController ?? this.titoloAlbumController,
      annoController: annoController ?? this.annoController,
      valoreController: valoreController ?? this.valoreController,
      brano1AController: brano1AController ?? this.brano1AController,
      brano2AController: brano2AController ?? this.brano2AController,
      brano3AController: brano3AController ?? this.brano3AController,
      brano4AController: brano4AController ?? this.brano4AController,
      brano5AController: brano5AController ?? this.brano5AController,
      brano6AController: brano6AController ?? this.brano6AController,
      brano7AController: brano7AController ?? this.brano7AController,
      brano8AController: brano8AController ?? this.brano8AController,
      brano1BController: brano1BController ?? this.brano1BController,
      brano2BController: brano2BController ?? this.brano2BController,
      brano3BController: brano3BController ?? this.brano3BController,
      brano4BController: brano4BController ?? this.brano4BController,
      brano5BController: brano5BController ?? this.brano5BController,
      brano6BController: brano6BController ?? this.brano6BController,
      brano7BController: brano7BController ?? this.brano7BController,
      brano8BController: brano8BController ?? this.brano8BController,
      tipologia: tipologia ?? this.tipologia,
      lato: lato ?? this.lato,
    );
  }
}

class DettaglioDiscoLoadingState extends DettaglioDiscoState {
  DettaglioDiscoLoadingState()
      : super(
          disco: const Disco(),
          artistaController: TextEditingController(),
          posizioneController: TextEditingController(),
          ordineController: TextEditingController(),
          titoloAlbumController: TextEditingController(),
          annoController: TextEditingController(),
          valoreController: TextEditingController(),
          brano1AController: TextEditingController(),
          brano2AController: TextEditingController(),
          brano3AController: TextEditingController(),
          brano4AController: TextEditingController(),
          brano5AController: TextEditingController(),
          brano6AController: TextEditingController(),
          brano7AController: TextEditingController(),
          brano8AController: TextEditingController(),
          brano1BController: TextEditingController(),
          brano2BController: TextEditingController(),
          brano3BController: TextEditingController(),
          brano4BController: TextEditingController(),
          brano5BController: TextEditingController(),
          brano6BController: TextEditingController(),
          brano7BController: TextEditingController(),
          brano8BController: TextEditingController(),
          tipologia: '33',
          lato: 'A',
        );
}
