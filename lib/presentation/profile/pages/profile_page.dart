import 'package:flutter/material.dart';

import '/common/widgets/appbar/app_bar.dart';

import '/presentation/profile/widgets/profile_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const BasicAppbar(title: 'Profilo Utente'),
      body: const SingleChildScrollView(
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
}
