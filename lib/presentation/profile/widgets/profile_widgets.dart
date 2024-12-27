import 'package:app_disco_teca/common/bloc/theme/theme_cubit.dart';
import 'package:app_disco_teca/common/widgets/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/service_locator.dart';

import '/common/widgets/loading_view.dart';
import '/common/helper/navigation/app_navigation.dart';
import '/common/widgets/dialog_standard.dart';

import '/presentation/profile/bloc/app_version_cubit.dart';
import '/presentation/profile/bloc/statistiche_cubit/statistiche_cubit.dart';
import '/presentation/profile/bloc/statistiche_cubit/statistiche_state.dart';
import '/presentation/auth/pages/signin.dart';
import '/presentation/profile/bloc/logout_cubit.dart';

class InfoItem {
  final IconData icon;
  final String label;
  final String value;

  InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class SezioneInformazioni extends StatelessWidget {
  final String title;
  final List<InfoItem> infoItems;

  const SezioneInformazioni({
    Key? key,
    required this.title,
    required this.infoItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 16),
          Column(
            children: infoItems.map((info) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Icon(
                      info.icon,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        info.label,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ),
                    Text(
                      info.value,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SezioneInfoUtente extends StatelessWidget {
  const SezioneInfoUtente({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = sl<FirebaseAuth>().currentUser?.email;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 16),
          Text(
            email ?? '',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );
  }
}

class SezioneStatistiche extends StatelessWidget {
  const SezioneStatistiche({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (_) => StatisticheCubit()..getStatistiche(),
        child: BlocBuilder<StatisticheCubit, StatisticheState>(
          builder: (context, state) {
            if (state is StatisticheLoading) {
              return const LoadingView();
            }
            if (state is StatisticheLoaded) {
              return SezioneInformazioni(
                title: 'Statistiche',
                infoItems: [
                  InfoItem(
                    icon: Icons.album,
                    label: 'Dischi',
                    value: state.nDischi.toString(),
                  ),
                  InfoItem(
                    icon: Icons.portrait_outlined,
                    label: 'Artisti',
                    value: state.nArtisti.toString(),
                  ),
                  InfoItem(
                    icon: Icons.all_inbox,
                    label: 'Albums',
                    value: state.nAlbum.toString(),
                  ),
                  InfoItem(
                    icon: Icons.star_outlined,
                    label: 'Brani',
                    value: state.nBrani.toString(),
                  ),
                ],
              );
            }
            return const LoadingView();
          },
        ),
      ),
    );
  }
}

class SezioneInfoVersioneApp extends StatelessWidget {
  const SezioneInfoVersioneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: BlocProvider(
        create: (_) => AppVersionCubit()..getVersione(),
        child: BlocBuilder<AppVersionCubit, String>(
          builder: (context, state) {
            return SezioneInformazioni(
              title: 'Informazioni App',
              infoItems: [
                InfoItem(
                  icon: Icons.info_outline,
                  label: 'Versione',
                  value: state,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SezioneLogout extends StatelessWidget {
  const SezioneLogout({
    Key? key,
  }) : super(key: key);

  void _showLogoutConfirmationDialog(BuildContext context) {
    dialogStandardPopUp(
      context: context,
      title: 'Disconnetti',
      content: 'Disconnettere l\'account?',
      acceptFunction: () {
        context.read<LogoutCubit>().logout();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      deniedFunction: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: BlocProvider(
        create: (_) => LogoutCubit(),
        child: BlocListener<LogoutCubit, bool>(
          listener: (context, state) {
            if (state == true) {
              AppNavigator.pushReplacement(context, SigninPage());
            }
          },
          child: Builder(
            builder: (context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () => _showLogoutConfirmationDialog(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    backgroundColor: Theme.of(context).colorScheme.error,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.exit_to_app),
                      if (!isDesktop) const SizedBox(width: 8),
                      if (!isDesktop)
                        Text(
                          'Logout',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onError,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(context.read<ThemeCubit>().isDarkTheme
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SezioneInfoUtente(),
            const SezioneStatistiche(),
            const SezioneInfoVersioneApp(),
            const SezioneLogout(),
          ],
        ),
      ),
    );
  }
}
