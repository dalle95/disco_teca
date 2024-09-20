import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/widgets/inputdecoration_textfield.dart';

import '/pages/auth/auth_controller.dart';
import '/pages/auth/bloc/auth_blocs.dart';
import '/pages/auth/bloc/auth_events.dart';

Widget buildLogo({required BuildContext context}) {
  return Column(
    children: [
      Icon(
        Icons.album,
        size: 100,
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(height: 24),
      Text(
        'DiscoTeca',
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 48,
            ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget buildForm({required BuildContext context}) {
  var state = context.read<AuthBloc>().state;

  return Column(
    children: [
      TextField(
        onChanged: (value) => context.read<AuthBloc>().add(
              UsernameEvent(value),
            ),
        decoration: buildInputDecoration(
          context: context,
          label: 'Email',
        ),
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      const SizedBox(height: 16),
      // Campo password con lo stesso stile
      TextField(
        onChanged: (value) => context.read<AuthBloc>().add(
              PasswordEvent(value),
            ),
        obscureText: true,
        decoration: buildInputDecoration(
          context: context,
          label: 'Password',
        ),
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      // Campo password? con lo stesso stile
      if (state.vista == 'Registrazione')
        Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => context.read<AuthBloc>().add(
                    Password2Event(value),
                  ),
              obscureText: true,
              decoration: buildInputDecoration(
                context: context,
                label: 'Ripeti Password',
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
    ],
  );
}

Widget buildPulsante({required BuildContext context}) {
  var state = context.read<AuthBloc>().state;

  return ElevatedButton(
    onPressed: () => AuthController(context: context).gestisciAutenticazione(),
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        state.vista == 'Login' ? 'Accedi' : 'Registrati',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    ),
  );
}

Widget buildPulsanteSwitchVista({required BuildContext context}) {
  var state = context.read<AuthBloc>().state;

  return TextButton(
    onPressed: () => context.read<AuthBloc>().add(const VistaEvent()),
    child: Text(
      state.vista == 'Login'
          ? 'Non hai un account? Registrati'
          : 'Accedi subito',
      style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
    ),
  );
}
