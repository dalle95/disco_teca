import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '/common/widgets/loading_view.dart';

import '/domain/foto_disco/entities/foto_disco.dart';

class ImageWidget extends StatelessWidget {
  final ImageData image;
  final int index;

  const ImageWidget({
    Key? key,
    required this.image,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImage(),
        Positioned(
          top: 10,
          left: 10,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              (index + 1).toString(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Card(
            color: Theme.of(context).colorScheme.primary,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
              child: Text(
                DateFormat('dd/MM/yyyy').format(image.timestamp),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    // Se ci sono dati in formato bytes (per il web)
    if (image.fileBytes != null) {
      return Center(
        child: Image.memory(
          image.fileBytes!,
          fit: BoxFit.cover,
        ),
      );
    }

    // Se il file è un URL (da Firebase Storage)
    if (image.file?.startsWith('http') == true) {
      return Center(
        child: CachedNetworkImage(
          imageUrl: image.file!,
          placeholder: (context, url) => LoadingView(),
          errorWidget: (context, url, error) {
            Logger().e(error);
            return const Icon(Icons.error);
          },
          fit: BoxFit.cover,
        ),
      );
    }

    // Se il file è un percorso locale
    if (image.file != null) {
      return Center(
        child: Image.file(
          File(image.file!),
          fit: BoxFit.cover,
        ),
      );
    }

    // Caso di fallback (immagine non disponibile)
    return const Center(
      child: Icon(
        Icons.image,
        color: Colors.grey,
      ),
    );
  }
}
