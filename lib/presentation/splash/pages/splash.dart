import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/background/background_view.dart';
import '/common/helper/navigation/app_navigation.dart';

import '/presentation/auth/pages/signin.dart';
import '/presentation/home/pages/home.dart';
import '../bloc/spash/splash_cubit.dart';

import '../bloc/spash/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            AppNavigator.pushReplacement(context, SigninPage());
          }

          if (state is Authenticated) {
            AppNavigator.pushReplacement(context, const HomePage());
          }
        },
        child: const BackGroundView(),
      ),
    );
  }
}
