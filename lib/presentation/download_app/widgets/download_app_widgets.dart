import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/configs/assets/app_images.dart';

import '/common/helper/navigation/app_navigation.dart';

import '/presentation/download_app/bloc/download/download_cubit.dart';
import '/presentation/home/pages/home.dart';

class DownloadInProgressWidget extends StatelessWidget {
  final double progress; // Valore da 0.0 a 1.0 (0% - 100%)
  final String assetPath; // Percorso dell'immagine del disco come asset

  const DownloadInProgressWidget({
    Key? key,
    required this.progress,
    required this.assetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Download in corso',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Immagine completa del disco
                  ClipOval(
                    child: Image.asset(
                      assetPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Maschera per la parte non scaricata
                  CustomPaint(
                    size: Size(
                      MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.width * 0.7,
                    ),
                    painter: DiskProgressPainter(progress),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '$percentage%',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class DiskProgressPainter extends CustomPainter {
  final double progress;

  DiskProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Rettangolo per il cerchio
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Pittura per la parte non scaricata (maschera scura)
    final Paint remainingPaint = Paint()
      ..color = Colors.black.withOpacity(0.7) // Colore semi-trasparente
      ..style = PaintingStyle.fill;

    // Angolo per la parte rimanente
    final sweepAngle = 2 * pi * (1 - progress);

    // Disegna la maschera scura per la parte rimanente
    canvas.drawArc(
      rect,
      -pi / 2 + 2 * pi * progress, // Inizio dal bordo della parte scaricata
      sweepAngle,
      true,
      remainingPaint,
    );
  }

  @override
  bool shouldRepaint(DiskProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class DownloadSuccessView extends StatelessWidget {
  const DownloadSuccessView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.white70,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          ElevatedButton(
            onPressed: () => AppNavigator.pushAndRemove(context, HomePage()),
            child: const Text(
              "Vai in homepage",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class PermissionDownloadView extends StatelessWidget {
  const PermissionDownloadView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => context.read<DownloadCubit>().downloadFile(),
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
              onPressed: () => AppNavigator.pushAndRemove(context, HomePage()),
              child: const Text(
                "Salta",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                foregroundColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
