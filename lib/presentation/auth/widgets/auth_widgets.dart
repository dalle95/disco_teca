import 'package:app_disco_teca/core/configs/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '/common/helper/navigation/app_navigation.dart';

import '/core/configs/assets/app_icons.dart';

import '../pages/register.dart';
import '/presentation/auth/pages/signin.dart';

Widget buildLogo({required BuildContext context}) {
  return Column(
    children: [
      SizedBox(
        height: 150,
        width: double.infinity,
        child: Image.asset(
          AppIcons.logo,
          fit: BoxFit.contain,
        ),
      ),
      SizedBox(
        height: 24,
      ),
      Text(
        'DiscoTeca',
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 48,
            ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget buildForm({
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  TextEditingController? passwordConfirmController,
}) {
  return Column(
    children: [
      TextField(
        controller: emailController,
        style: TextStyle(
          color: AppColors.accent,
        ),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: const TextStyle(
            color: AppColors.accent,
          ),

          hintStyle: const TextStyle(
            color: AppColors
                .secondBackground, // Colore del testo segnaposto (hint)
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: AppColors.surface.withOpacity(0.9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Bordo arrotondato
            borderSide: const BorderSide(
              color: AppColors.surface, // Colore del bordo quando non è attivo
              width: 1,
            ),
          ),

          // Configurazione del bordo abilitato (quando il campo non è in focus)
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.surface,
              width: 1,
            ),
          ),

          // Configurazione del bordo in focus
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.accent,
              width: 2.5, // Bordo più spesso quando è selezionato
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      // Campo password con lo stesso stile
      TextField(
        controller: passwordController,
        obscureText: true,
        style: TextStyle(
          color: AppColors.accent,
        ),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: const TextStyle(
            color: AppColors.accent,
          ), // Colore per l'etichetta (label)
          hintStyle: const TextStyle(
            color: AppColors
                .secondBackground, // Colore del testo segnaposto (hint)
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: AppColors.surface.withOpacity(0.9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Bordo arrotondato
            borderSide: const BorderSide(
              color: AppColors.surface, // Colore del bordo quando non è attivo
              width: 1,
            ),
          ),

          // Configurazione del bordo abilitato (quando il campo non è in focus)
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.surface,
              width: 1,
            ),
          ),

          // Configurazione del bordo in focus
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColors.accent,
              width: 2.5, // Bordo più spesso quando è selezionato
            ),
          ),
        ),
      ),

      // Campo password con lo stesso stile
      if (passwordConfirmController != null)
        Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: passwordConfirmController,
              obscureText: true,
              style: TextStyle(
                color: AppColors.accent,
              ),
              decoration: InputDecoration(
                labelText: 'Ripeti password',
                labelStyle: const TextStyle(
                  color: AppColors.accent,
                ), // Colore per l'etichetta (label)
                hintStyle: const TextStyle(
                  color: AppColors
                      .secondBackground, // Colore del testo segnaposto (hint)
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: AppColors.surface.withOpacity(0.9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Bordo arrotondato
                  borderSide: const BorderSide(
                    color: AppColors
                        .surface, // Colore del bordo quando non è attivo
                    width: 1,
                  ),
                ),

                // Configurazione del bordo abilitato (quando il campo non è in focus)
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: AppColors.surface,
                    width: 1,
                  ),
                ),

                // Configurazione del bordo in focus
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: AppColors.accent,
                    width: 2.5, // Bordo più spesso quando è selezionato
                  ),
                ),
              ),
            ),
          ],
        )
    ],
  );
}

Widget buildPulsante({
  required BuildContext context,
  required String lable,
  required void Function()? onPress,
}) {
  return ElevatedButton(
    onPressed: onPress,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        lable,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
  );
}

Widget buildRegisterText(BuildContext context) {
  return Text.rich(
    textAlign: TextAlign.center,
    TextSpan(
      children: [
        const TextSpan(
          text: "Non hai un account?",
          style: TextStyle(color: Colors.white70),
        ),
        TextSpan(
          text: ' Registrati',
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, RegisterPage());
            },
        )
      ],
    ),
  );
}

Widget buildSignInText(BuildContext context) {
  return Text.rich(
    textAlign: TextAlign.center,
    TextSpan(
      children: [
        const TextSpan(
          text: "Hai già un account?",
          style: TextStyle(color: Colors.white70),
        ),
        TextSpan(
          text: ' Accedi',
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, SigninPage());
            },
        )
      ],
    ),
  );
}
