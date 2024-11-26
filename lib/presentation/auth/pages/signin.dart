import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/background/background_view.dart';
import '/presentation/auth/widgets/auth_widgets.dart';
import '/domain/auth/usecases/signin.dart';
import '/service_locator.dart';
import '/common/helper/navigation/app_navigation.dart';
import '/domain/auth/usecases/register.dart';
import '/presentation/auth/bloc/auth_cubit.dart';
import '/presentation/auth/bloc/auth_state.dart';
import '/presentation/home/pages/home.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(sl<SigninUseCase>(), sl<RegisterUseCase>()),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              // Display errore
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            } else if (state.isSuccess) {
              // Navigazione alla homepage
              AppNavigator.pushAndRemove(context, const HomePage());
            }
          },
          child: Stack(
            children: [
              const BackGroundView(),
              SafeArea(
                minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildLogo(context: context),
                      const SizedBox(
                        height: 30,
                      ),
                      buildForm(
                        context: context,
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return buildPulsante(
                            context: context,
                            lable:
                                state.isLoading ? 'Caricamento...' : 'Accedi',
                            onPress: state.isLoading
                                ? null
                                : () {
                                    context.read<AuthCubit>().signIn(
                                          _emailController.text,
                                          _passwordController.text,
                                        );
                                  },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildRegisterText(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
