abstract class ListaPosizioniState {}

class ListaPosizioniLoading extends ListaPosizioniState {}

class ListaPosizioniLoaded extends ListaPosizioniState {
  final List<String> lista;
  ListaPosizioniLoaded({required this.lista});
}

class ListaPosizioniFailureLoad extends ListaPosizioniState {
  final String errorMessage;
  ListaPosizioniFailureLoad({required this.errorMessage});
}
