import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Supported locales provider (English default)
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

/// Simple localization helper that reads translations from lib/i18n/*.json.
class AppLocalizations {
  static const supportedLocales = [Locale('en'), Locale('km')];

  /// Cache of translations per language code
  static final Map<String, Map<String, dynamic>> _localizedValues = {};

  /// Preload all supported locales. Call before runApp so translations are ready.
  static Future<void> preload() async {
    await Future.wait(
      supportedLocales.map((locale) => _loadLocale(locale.languageCode)),
    );
  }

  static Future<void> _loadLocale(String code) async {
    if (_localizedValues.containsKey(code)) return;
    final path = 'lib/i18n/$code.json';
    final jsonString = await rootBundle.loadString(path);
    final data = json.decode(jsonString) as Map<String, dynamic>;
    _localizedValues[code] = data;
  }

  /// Translate a dotted key based on current locale from ProviderScope, e.g. "nav.home".
  static String t(BuildContext context, String key) {
    final container = ProviderScope.containerOf(context);
    final locale = container.read(localeProvider);
    final code = locale.languageCode;
    return _translate(code, key) ?? _translate('en', key) ?? key;
  }

  static String? _translate(String code, String key) {
    final map = _localizedValues[code];
    if (map == null) return null;
    final segments = key.split('.');
    dynamic current = map;
    for (final segment in segments) {
      if (current is Map<String, dynamic> && current.containsKey(segment)) {
        current = current[segment];
      } else {
        return null;
      }
    }
    if (current is String) return current;
    if (current != null) return current.toString();
    return null;
  }
}
