import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '/core/configs/assets/app_images.dart';

import '../blocs/onboarding_cubit.dart';

import '/common/helper/navigation/app_navigation.dart';

import '/presentation/home/pages/home.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, int>(
          builder: (context, pageIndex) {
            return IntroductionScreen(
              globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pages: _buildPages(context),
              onDone: () {
                AppNavigator.pushReplacement(context, HomePage());
              },
              onChange: (index) {
                context.read<OnboardingCubit>().nextPage(index);
              },
              done: const Text("Inizia!",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              next: const Icon(Icons.arrow_forward),
              skip: const Text("Salta"),
              showSkipButton: true,
              dotsDecorator: const DotsDecorator(
                size: Size(8.0, 8.0),
                color: Colors.grey,
                activeSize: Size(16.0, 8.0),
                activeColor: Colors.blue,
                spacing: EdgeInsets.symmetric(horizontal: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<PageViewModel> _buildPages(BuildContext context) {
    return [
      PageViewModel(
        title: "Benvenuto su DiscoTeca 🎵",
        body:
            "L'app definitiva per gestire la tua collezione di vinili in modo semplice e intuitivo.",
        image: _buildImage(AppImages.onboarding0),
        decoration: _pageDecoration(),
      ),
      PageViewModel(
        title: "Organizza i tuoi vinili 📀",
        body:
            "Aggiungi facilmente nuovi dischi, completa le informazioni e consulta la tua collezione ovunque.",
        image: _buildImage(AppImages.onboarding1),
        decoration: _pageDecoration(),
      ),
      PageViewModel(
        title: "Trova il disco perfetto 🔎",
        body:
            "Usa la ricerca avanzata e i filtri per trovare rapidamente i tuoi dischi preferiti.",
        image: _buildImage(AppImages.onboarding2),
        decoration: _pageDecoration(),
      ),
      PageViewModel(
        title: "Aggiungi dischi con una foto 📸",
        body:
            "Scatta una foto del vinile e lascia che l'intelligenza artificiale compili i dati per te.",
        image: _buildImage(AppImages.onboarding4),
        decoration: _pageDecoration(),
      ),
      PageViewModel(
        title: "Accedi in modo rapido e sicuro 🔐",
        body:
            "Effettua il login con Google e sincronizza la tua collezione su tutti i dispositivi.",
        image: _buildImage(AppImages.onboarding5),
        decoration: _pageDecoration(),
      ),
      PageViewModel(
        title: "Sei pronto a partire? 🚀",
        body:
            "Inizia subito ad esplorare la tua collezione e a gestire i tuoi vinili in modo smart!",
        image: _buildImage(AppImages.onboarding3),
        decoration: _pageDecoration(),
      ),
    ];
  }

  Widget _buildImage(String path) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge, // Per rispettare i bordi arrotondati
      child: Image.asset(
        path,
        width: 300, // Dimensione maggiore
        height: 250, // Altezza più grande
        fit: BoxFit.cover,
      ),
    );
  }

  PageDecoration _pageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 16.0),
      imagePadding: EdgeInsets.all(20),
    );
  }
}
