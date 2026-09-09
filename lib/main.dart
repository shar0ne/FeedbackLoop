import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:feedback_loop/core/routes/app_router.dart';
import 'package:feedback_loop/core/theme/dark_theme.dart';
import 'package:feedback_loop/core/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  usePathUrlStrategy();
  runApp(
    const ProviderScope(
      child: MainApp()
    )
  );

  FlutterNativeSplash.remove();

}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp.router(
      title: "Feedback Loop",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
