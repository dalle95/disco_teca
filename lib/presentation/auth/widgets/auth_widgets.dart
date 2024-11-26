import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '/common/helper/navigation/app_navigation.dart';

import '../pages/register.dart';
import '/presentation/auth/pages/signin.dart';

Widget buildLogo({required BuildContext context}) {
  return Column(
    children: [
      Icon(
        Icons.album,
        size: 100,
        color: Theme.of(context).primaryColor,
      ),
      const SizedBox(height: 24),
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
        decoration: const InputDecoration(
          labelText: 'Email',
        ),
      ),
      const SizedBox(height: 16),
      // Campo password con lo stesso stile
      TextField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
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
              decoration: const InputDecoration(
                labelText: 'Ripeti password',
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
        const TextSpan(text: "Non hai un account?"),
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
        const TextSpan(text: "Hai già un account?"),
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
