import 'package:app_disco_teca/core/configs/assets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/configs/assets/app_icons.dart';

import '/common/helper/navigation/app_navigation.dart';

import '/presentation/download_app/widgets/download_app_widgets.dart';
import '/presentation/download_app/bloc/download/download_cubit.dart';
import '/presentation/download_app/bloc/download/download_state.dart';
import '/presentation/home/pages/home.dart';

class FileDownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Download Nuova Versione App")),
      body: BlocProvider(
        create: (_) => DownloadCubit(),
        child: BlocConsumer<DownloadCubit, DownloadState>(
          listener: (context, state) {
            if (state is DownloadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Errore: ${state.error}")),
              );
            } else if (state is DownloadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Download completato!")),
              );
            }
          },
          builder: (context, state) {
            if (state is DownloadInProgress) {
              return Center(
                child: DownloadWidget(
                  progress: state.progress,
                  assetPath: AppIcons.logo,
                ),
              );
            } else if (state is DownloadSuccess) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      AppImages.splashBackground,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Text(
                        'Qualcosa non è andato come doveva...\nMa non ti preoccupare ci riproveremo!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          AppNavigator.pushAndRemove(context, HomePage()),
                      child: const Text(
                        "Vai in homepage",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DownloadFailure) {
              return Center(child: Text("Errore: ${state.error}"));
            }

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.splashBackground,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Text(
                      'È presente una nuova versione dell\'app.\nScaricarla?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<DownloadCubit>().downloadFile(),
                      child: const Text(
                        "Scarica",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          AppNavigator.pushAndRemove(context, HomePage()),
                      child: const Text(
                        "Salta",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onBackground,
                        foregroundColor: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
