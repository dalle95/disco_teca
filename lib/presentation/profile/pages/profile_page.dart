import 'package:app_disco_teca/common/bloc/theme/theme_cubit.dart';
import 'package:app_disco_teca/presentation/profile/widgets/button_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/appbar/app_bar.dart';
import '/common/widgets/responsive.dart';

import '/presentation/profile/widgets/profile_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: _buildDesktopView(context),
      mobile: _buildMobileView(context),
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Profilo Utente'),
        actions: [
          ButtonChangeTheme(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SezioneInfoUtente(),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: SezioneStatistiche(),
            ),
            SezioneInfoVersioneApp(),
            SezioneLogout(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopView(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Profilo Utente'),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: ButtonChangeTheme(),
          ),
          SezioneLogout(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: SezioneInfoUtente()),
                  SezioneInfoVersioneApp(),
                ],
              ),
            ),
            Expanded(child: SezioneStatistiche()),
          ],
        ),
      ),
    );
  }
}
