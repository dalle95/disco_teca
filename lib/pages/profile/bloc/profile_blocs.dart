import 'package:disco_teca/commons/values/constant.dart';
import 'package:disco_teca/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'profile_events.dart';
import 'profile_states.dart';

import '/commons/data/api/dischi_api.dart';
import '/commons/data/helpers/data_helpers.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
    on<ProfileDatiEvent>(_datiEvent);
    on<LoadingEvent>(_loadingEvent);
  }

  Future<void> _datiEvent(
      ProfileDatiEvent event, Emitter<ProfileState> emit) async {
    // Recupero il numero dei dischi
    final listaDischi = await DiscoApi().estraiDati();
    final nDischi = DataHelpers().estraiNumeroDischi(listaDischi);

    // Recupero la versione dell'applicazione
    final infoApp = await PackageInfo.fromPlatform();
    final infoVersioneApp = '${infoApp.version}+${infoApp.buildNumber}';

    // Recupero l'email
    final userData = await Global.storageService.estraiDatiUtente();
    final userEmail = userData['email'];

    emit(
      state.copyWith(
        email: userEmail,
        nDischi: nDischi,
        versioneApp: infoVersioneApp,
      ),
    );
  }

  void _loadingEvent(LoadingEvent event, Emitter<ProfileState> emit) {
    emit(ProfileLoadingState());
  }
}
