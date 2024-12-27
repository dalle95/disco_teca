import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/core/configs/theme/app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  final FlutterSecureStorage _storage = sl<FlutterSecureStorage>();
  final Logger _logger = sl<Logger>();

  ThemeCubit() : super(AppTheme.lightTheme) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _logger.d('ThemeCubit | _loadTheme');
    final isDark = (await _storage.read(key: 'isDarkTheme')) == 'true';
    emit(isDark ? AppTheme.darkTheme : AppTheme.lightTheme);
  }

  Future<void> toggleTheme() async {
    _logger.d('ThemeCubit | toggleTheme');
    emit(isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme);
    await _storage.write(key: 'isDarkTheme', value: (!isDarkTheme).toString());
  }

  bool get isDarkTheme => state.colorScheme.brightness == Brightness.light;
}
