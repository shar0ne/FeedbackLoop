import 'package:feedback_loop/presentation/widgets/navigation_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavBar extends ConsumerWidget {
  final Widget screen;

  const ScaffoldNavBar({
    super.key,
    required this.screen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    int currentIndex = 0;
    if (location.startsWith('/new-idea')) {
      currentIndex = 1;
    } else if (location.startsWith('/profile')) {
      currentIndex = 2;
    }

    return Scaffold(
      body: SafeArea(
        child: screen,
      ),
      bottomNavigationBar: NavigationBarCustom(
        selectedIndex: currentIndex,
      ),
    );
  }
}