import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/helper/assets/assets_utils.dart';
import '/common/helper/navigation/app_navigation.dart';
import '/common/widgets/loading_view.dart';
import '/common/widgets/responsive.dart';

import '/presentation/dettaglio_disco/pages/dettaglio_disco_page.dart';
import '/presentation/home/bloc/dettaglio_disco_desktop_cubit.dart';

class DiscoItem extends StatelessWidget {
  final BuildContext context;
  final dynamic disco;

  const DiscoItem({
    Key? key,
    required this.context,
    required this.disco,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          onTap: () => isMobile
              ? AppNavigator.push(context, DettaglioDiscoPage(disco: disco))
              : context.read<DettaglioDiscoDesktopCubit>().setDisco(disco),
          title: Text(
            disco.artista!,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          subtitle: Text(
            '${disco.titoloAlbum} - ${disco.anno}',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          leading: GestureDetector(
            onTap: () => _showImagePopup(context, disco),
            child: SizedBox(
              width: 48,
              height: 50,
              child: disco.anteprima == null
                  ? Image.asset(
                      getIconPath(
                        disco.giri,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: disco.anteprima!,
                      placeholder: (context, url) => LoadingView(noTitle: true),
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ordine',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),
                Text(
                  disco.ordine == null ? 'Nessuno' : disco.ordine.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePopup(BuildContext context, dynamic disco) {
    if (disco.anteprima == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nessuna immagine disponibile.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Angoli arrotondati
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Dimensioni dinamiche per adattarsi a mobile e web
              double popupWidth = Responsive.isMobile(context)
                  ? constraints.maxWidth
                  : constraints.maxWidth * 0.8;
              double popupHeight = Responsive.isMobile(context)
                  ? constraints.maxHeight * 0.7
                  : constraints.maxHeight;

              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: disco.anteprima!,
                      placeholder: (context, url) => Container(
                        height: popupHeight,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: popupWidth,
                      height: popupHeight,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black
                              .withOpacity(0.7), // Sfondo semi-trasparente
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(16),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              disco.titoloAlbum ?? 'Titolo non disponibile',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              disco.artista ?? 'Artista non disponibile',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
