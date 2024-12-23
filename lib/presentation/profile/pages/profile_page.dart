import 'package:app_disco_teca/common/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '/common/widgets/appbar/app_bar.dart';

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
      appBar: const BasicAppbar(title: 'Profilo Utente'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SezioneInfoUtente(),
            SezioneStatistiche(),
            SezioneInfoVersioneApp(),
            SezioneLogout(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopView(BuildContext context) {
    Logger().e('Building desktop view'); // Debugging line
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Profilo Utente'),
        actions: [
          SezioneLogout(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 16),
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
