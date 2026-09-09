import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider fournissant le mode du thème appliqué
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeMode> {

  @override
  ThemeMode build() => ThemeMode.system;

  void toggle(BuildContext context) {
    state = Theme.of(context).brightness == Brightness.light ?
    ThemeMode.dark :
    ThemeMode.light;
  }

}

// provider pour verifier si on est en darkMode ou pas
final isDarkProvider = Provider<bool>((ref){

  final themeMode = ref.watch(themeProvider);
  
  switch (themeMode) {
    case ThemeMode.light: return false;
    case ThemeMode.dark: return true;
    default: return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }

});