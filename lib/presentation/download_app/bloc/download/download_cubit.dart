import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';

import '/service_locator.dart';

import '/domain/download_app/usescases/download_app.dart';

import '/presentation/download_app/bloc/download/download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final DownloadAppUseCase _downloadAppUseCase = sl<DownloadAppUseCase>();

  DownloadCubit() : super(DownloadInitial());

  Future<void> downloadFile() async {
    emit(DownloadInProgress(0.0));

    final result = await _downloadAppUseCase.call(
      params: (double progress) {
        emit(DownloadInProgress(progress)); // Aggiorna il progresso
      },
    );

    result.fold(
      (error) => emit(DownloadFailure(error)), // Errore
      (filePath) async {
        // Apertura del file
        final openResult = await OpenFilex.open(filePath);

        if (openResult.type == ResultType.done) {
          emit(DownloadSuccess(filePath)); // File aperto con successo
        } else {
          emit(DownloadFailure(
              "Errore durante l'apertura del file: ${openResult.message}"));
        }
      },
    );
  }
}
