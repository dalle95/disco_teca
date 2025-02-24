class ListaPosizioniState {
  final bool isLoading;
  final String? errorMessage;
  final List<String> lista;

  const ListaPosizioniState({
    this.isLoading = false,
    this.errorMessage,
    this.lista = const [],
  });

  ListaPosizioniState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<String>? lista,
  }) {
    return ListaPosizioniState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      lista: lista ?? this.lista,
    );
  }
}
