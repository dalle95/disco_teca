import 'package:flutter/widgets.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  const Responsive({
    required this.mobile,
    this.tablet,
    required this.desktop,
    super.key,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 904;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 1280 &&
      MediaQuery.sizeOf(context).width >= 904;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1280;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    if (size.width >= 1280) {
      return desktop;
    } else if (size.width >= 904 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}