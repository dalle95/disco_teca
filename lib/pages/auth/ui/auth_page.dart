import 'dart:ui';

import 'package:disco_teca/commons/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/pages/auth/widgets/auth_widgets.dart';
import '/pages/auth/bloc/auth_blocs.dart';
import '/pages/auth/bloc/auth_states.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: state is AuthLoadingState
              ? buildLoadingView(context: context)
              : Stack(
                  children: [
                    // Background con effetto vinile
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/vinyl-texture.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Effetto sfocatura
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    // Contenuto principale
                    Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Logo o titolo dell'app
                              buildLogo(context: context),
                              const SizedBox(height: 48),
                              // Campo email con lo stile aggiornato
                              buildForm(context: context),
                              const SizedBox(height: 24),
                              // Pulsante di login
                              buildPulsante(context: context),
                              const SizedBox(height: 16),
                              // Link per registrazione
                              buildPulsanteSwitchVista(context: context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
