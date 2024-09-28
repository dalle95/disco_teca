class FiltroDischiState {
  final String? giri;
  final String? posizione;
  List<String> listaPosizioni;

  FiltroDischiState({
    this.giri,
    this.posizione,
    this.listaPosizioni = const [],
  });

  factory FiltroDischiState.initial() {
    return FiltroDischiState(
      giri: null,
      posizione: null,
      listaPosizioni: [],
    );
  }

  FiltroDischiState copyWith({
    String? posizione,
    String? giri,
    List<String>? listaPosizioni,
  }) {
    return FiltroDischiState(
      giri: giri ?? this.giri,
      posizione: posizione ?? this.posizione,
      listaPosizioni: listaPosizioni ?? this.listaPosizioni,
    );
  }
}

class FiltroDischiLoadingState extends FiltroDischiState {
  FiltroDischiLoadingState()
      : super(
          giri: null,
          posizione: null,
          listaPosizioni: [],
        );
}
