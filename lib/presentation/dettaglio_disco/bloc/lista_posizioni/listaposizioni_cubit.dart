import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/domain/disco/usescases/get_dischi.dart';
import '/presentation/dettaglio_disco/bloc/lista_posizioni/listaposizioni_state.dart';

class ListaPosizioniCubit extends Cubit<ListaPosizioniState> {
  ListaPosizioniCubit() : super(ListaPosizioniLoading());

  // Per gestire i log
  final logger = sl<Logger>();

  void getListaPosizioni() async {
    logger.d('ListaPosizioniCubit | Funzione: getListaPosizioni');

    var returnedData = await sl<GetDischiUseCase>().call();

    returnedData.fold(
      (error) {
        emit(ListaPosizioniFailureLoad(errorMessage: error));
      },
      (data) {
        emit(
          ListaPosizioniLoaded(
            lista: data
                .map((r) => r.posizione)
                .where((posizione) => posizione != null)
                .cast<String>()
                .toSet()
                .toList(),
          ),
        );
      },
    );
  }
}
