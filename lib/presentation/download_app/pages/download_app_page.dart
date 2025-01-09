import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/configs/assets/app_icons.dart';

import '/presentation/download_app/widgets/download_app_widgets.dart';
import '/presentation/download_app/bloc/download/download_cubit.dart';
import '/presentation/download_app/bloc/download/download_state.dart';

class FileDownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return DownloadInProgressWidget(
                progress: state.progress,
                assetPath: AppIcons.logo,
              );
            } else if (state is DownloadSuccess) {
              return DownloadSuccessView();
            } else if (state is DownloadFailure) {
              return Center(child: Text("Errore: ${state.error}"));
            }

            return PermissionDownloadView();
          },
        ),
      ),
    );
  }
}
