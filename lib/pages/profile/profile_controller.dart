import 'package:disco_teca/pages/profile/bloc/profile_blocs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/widgets/dialog_standard.dart';

import '/pages/auth/auth_controller.dart';

class ProfileController {
  final BuildContext context;

  const ProfileController({required this.context});

  // Funzione per estrarre l'email dell'utente
  String estraiEmail() {
    return context.read<ProfileBloc>().state.email!;
  }

  // Funzione per estrarre la versione dell'app
  String estraiVersioneApp() {
    return context.read<ProfileBloc>().state.versioneApp;
  }

  // Funzione per estrarre il numero dei dischi
  String estraiNDischi() {
    return context.read<ProfileBloc>().state.nDischi.toString();
  }

  /// Dialogo per effettuare il logout
  void profileDialog() {
    dialogStandardPopUp(
      context: context,
      title: 'Disconnetti',
      content: 'Disconnettere l\'account?',
      acceptFunction: () {
        removeUserData();
      },
      deniedFunction: () {},
    );
  }

  // Funzione per effetturare il logout
  Future<void> removeUserData() async {
    AuthController(context: context).logout();
  }
}
