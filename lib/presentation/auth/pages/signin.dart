import 'package:app_disco_teca/presentation/onboarding/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/responsive.dart';
import '/common/helper/navigation/app_navigation.dart';

import '/core/configs/assets/app_images.dart';

import '/presentation/auth/widgets/google_signin_button.dart';
import '/presentation/auth/bloc/auth_cubit.dart';
import '/presentation/auth/bloc/auth_state.dart';
import '/presentation/home/pages/home.dart';
import '/presentation/auth/widgets/auth_widgets.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
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
              AppNavigator.pushAndRemove(context, const OnboardingPage());
            }
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.splashBackground,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Responsive(
              desktop: _buildView(context),
              tablet: _buildView(context),
              mobile: _buildMobileView(context),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the main view for desktop and tablet with logo, form, and buttons.
  ///
  /// The view includes:
  /// - Logo at the top
  /// - Email and password form fields
  /// - Sign in button
  /// - Register text link
  SafeArea _buildView(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 800,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildLogo(context: context),
            const SizedBox(height: 30),
            SizedBox(
              width: 350,
              child: buildForm(
                context: context,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildPulsante(
                        context: context,
                        lable: state.isLoading ? 'Caricamento...' : 'Accedi',
                        onPress: state.isLoading
                            ? null
                            : () {
                                context.read<AuthCubit>().signIn(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                              },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Oppure',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white70,
                                ),
                      ),
                      const SizedBox(height: 20),
                      GoogleSignInButton(
                        isLoading: state.isLoading,
                        onPressed: state.isLoading
                            ? () {}
                            : () {
                                context.read<AuthCubit>().signInWithGoogle();
                              },
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Register text link
            buildRegisterText(context),
          ],
        ),
      ),
    );
  }

  /// Builds the mobile view with logo, form, button, and register text link
  ///
  /// The view includes:
  /// - Logo at the top
  /// - Email and password form fields
  /// - Sign in button with loading state
  /// - Register text link
  ///
  /// The view is scrollable and has a stretch layout to fill the available space.
  SafeArea _buildMobileView(
    BuildContext context,
  ) {
    return SafeArea(
      minimum: EdgeInsets.only(left: 20, right: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildPulsante(
                        context: context,
                        lable: state.isLoading ? 'Caricamento...' : 'Accedi',
                        onPress: state.isLoading
                            ? null
                            : () {
                                context.read<AuthCubit>().signIn(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                              },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Oppure',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white70,
                                ),
                      ),
                      const SizedBox(height: 20),
                      GoogleSignInButton(
                        isLoading: state.isLoading,
                        onPressed: state.isLoading
                            ? () {}
                            : () {
                                context.read<AuthCubit>().signInWithGoogle();
                              },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              buildRegisterText(context),
            ],
          ),
        ),
      ),
    );
  }
}
