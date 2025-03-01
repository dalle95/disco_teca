import 'package:app_disco_teca/common/widgets/loading_view.dart';
import 'package:app_disco_teca/presentation/dettaglio_disco/bloc/dettaglio_disco_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../bloc/foto_disco_cubit.dart';
import '../widgets/foto_disco_widgets.dart';

class FotoDiscoPage extends StatelessWidget {
  const FotoDiscoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foto Disco'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: BlocBuilder<FotoDiscoCubit, FotoDiscoState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return LoadingView(
                      title: 'Analisi in corso...',
                    );
                  }
                  final images = state.selectedSide == 'Fronte'
                      ? state.frontImages
                      : state.backImages;
                  if (images.isEmpty) {
                    return const Text('Nessuna immagine per questo lato.');
                  } else {
                    return PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (index) {
                        context.read<FotoDiscoCubit>().setCurrentIndex(index);
                      },
                      itemBuilder: (context, index) {
                        return ImageWidget(
                          image: images[index],
                          index: index,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          BlocBuilder<FotoDiscoCubit, FotoDiscoState>(
            builder: (context, state) {
              return ToggleButtons(
                isSelected: [
                  state.selectedSide == 'Fronte',
                  state.selectedSide == 'Retro'
                ],
                onPressed: (index) {
                  context
                      .read<FotoDiscoCubit>()
                      .toggleSide(index == 0 ? 'Fronte' : 'Retro');
                },
                fillColor: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
                borderColor: Theme.of(context).colorScheme.primary,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Fronte'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Retro'),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
      floatingActionButton: BlocBuilder<FotoDiscoCubit, FotoDiscoState>(
        builder: (context, state) {
          final images = state.selectedSide == 'Fronte'
              ? state.frontImages
              : state.backImages;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.frontImages.isNotEmpty &&
                  state.backImages.isNotEmpty &&
                  context.read<DettaglioDiscoCubit>().state.id == null)
                IconButton(
                  icon: CircleAvatar(
                    radius: 25,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.document_scanner_outlined,
                      size: 30,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  onPressed: () async {
                    await context.read<FotoDiscoCubit>().analyzeImages(context);
                    Navigator.of(context).pop();
                  },
                ),
              if (images.isNotEmpty)
                IconButton(
                  icon: CircleAvatar(
                    radius: 25,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.delete_forever_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  onPressed: () {
                    context.read<FotoDiscoCubit>().deleteImage();
                  },
                ),
              IconButton(
                onPressed: () => _showImageSourceActionSheet(context),
                icon: CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<FotoDiscoCubit>(),
          child: SafeArea(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (!kIsWeb)
                  ListTile(
                    minVerticalPadding: 10,
                    leading: Icon(
                      Icons.camera,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Fotocamera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      context
                          .read<FotoDiscoCubit>()
                          .pickAnCropImage(context, ImageSource.camera);
                    },
                  ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Galleria'),
                  onTap: () {
                    context
                        .read<FotoDiscoCubit>()
                        .pickAnCropImage(context, ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
