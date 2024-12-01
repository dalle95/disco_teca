import 'package:flutter/material.dart';
import 'dart:math';

class DownloadWidget extends StatelessWidget {
  final double progress; // Valore da 0.0 a 1.0 (0% - 100%)
  final String assetPath; // Percorso dell'immagine del disco come asset

  const DownloadWidget({
    Key? key,
    required this.progress,
    required this.assetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Download in corso',
          style: TextStyle(
            fontSize: 25,
            //fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        Text(
          '$percentage%',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
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
