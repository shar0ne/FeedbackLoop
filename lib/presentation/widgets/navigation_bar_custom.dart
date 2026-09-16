import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationBarCustom extends ConsumerWidget {
  final int selectedIndex;

  const NavigationBarCustom({
    super.key,
    required this.selectedIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/new-idea');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      height: 64,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : const Color(0xFF333333),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavBarItem(
            index: 0,
            isSelected: selectedIndex == 0,
            selectedIcon: Icons.home,
            unselectedIcon: Icons.home_outlined,
            isDark: isDark,
            onTap: () => _onItemTapped(context, 0),
          ),
          _NavBarItem(
            index: 1,
            isSelected: selectedIndex == 1,
            selectedIcon: Icons.add_box,
            unselectedIcon: Icons.add_box_outlined,
            isDark: isDark,
            onTap: () => _onItemTapped(context, 1),
          ),
          _NavBarItem(
            index: 2,
            isSelected: selectedIndex == 2,
            selectedIcon: Icons.person,
            unselectedIcon: Icons.person_outline,
            isDark: isDark,
            onTap: () => _onItemTapped(context, 2),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final bool isDark;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.index,
    required this.isSelected,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mintGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          isSelected ? selectedIcon : unselectedIcon,
          size: 32,
          color: isSelected
              ? AppColors.primary
              : (isDark ? AppColors.darkSubtext : Colors.black87),
        ),
      ),
    );
  }
}
