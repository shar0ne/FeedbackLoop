import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkProvider);

    return Center(
      child: Image.asset(
        isDark ?
        "assets/image/logo/feedback-loop-dark.png" :
        "assets/image/logo/feedback-loop-light.png",
        width: 300,
        // fit: BoxFit.fitWidth,
      ),
    );
  }
}