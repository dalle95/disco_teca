import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/commons/widgets/loading_view.dart';

import '/pages/profile/widgets/profile_widgets.dart';
import '/pages/profile/profile_controller.dart';
import '/pages/profile/bloc/profile_blocs.dart';
import '/pages/profile/bloc/profile_states.dart';
import '/pages/profile/bloc/profile_events.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(ProfileDatiEvent()),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: buildAppBar(
            context: context,
          ),
          body: state is ProfileLoadingState
              ? buildLoadingView(context: context)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildUserInfoSection(context),
                      _buildStatisticsSection(context),
                      _buildAppInfoSection(context),
                      _buildLogoutSection(context),
                    ],
                  ),
                ),
        );
      }),
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    final email = ProfileController(context: context).estraiEmail();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.person,
              size: 50,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 16),
          Text(
            email,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(BuildContext context) {
    final nDischi = ProfileController(context: context).estraiNDischi();

    return buildInfoSection(
      context: context,
      title: 'Statistiche',
      icon: Icons.album,
      label: 'Dischi caricati',
      value: nDischi,
    );
  }

  Widget _buildAppInfoSection(BuildContext context) {
    final versioneApp = ProfileController(context: context).estraiVersioneApp();

    return buildInfoSection(
      context: context,
      title: 'Informazioni App',
      icon: Icons.info_outline,
      label: 'Versione',
      value: versioneApp,
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          // Implementa qui la logica per il logout
          _showLogoutConfirmationDialog(context);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onError,
          backgroundColor: Theme.of(context).colorScheme.error,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.exit_to_app),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onError,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    ProfileController(context: context).profileDialog();
  }
}
