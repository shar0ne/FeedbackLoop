import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldNavBar extends ConsumerWidget {
  const ScaffoldNavBar({super.key, required this.screen});

  final Widget screen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Placeholder()
      ),
    );
  }
}