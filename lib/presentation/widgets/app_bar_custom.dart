import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarCustom extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final bool isHome;

  const AppBarCustom({
    super.key,
    required this.title,
    this.isHome = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: isHome
          ? RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : Colors.black,
                ),
                children: const [
                  TextSpan(text: 'Feedback'),
                  TextSpan(
                    text: 'Loop',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
      actions: [
        ThemePopupMenuCustom(isDark: isDark),
      ],
    );
  }
}

class ThemePopupMenuCustom extends ConsumerWidget {
  final bool isDark;

  const ThemePopupMenuCustom({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: isDark ? AppColors.darkText : Colors.black,
        size: 28,
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? AppColors.darkBorder : Colors.black12,
        ),
      ),
      color: isDark ? AppColors.darkCard : AppColors.lightBg,
      offset: const Offset(0, 48),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.nightlight_round,
                size: 20,
                color: isDark ? AppColors.darkText : Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                'Mode sombre',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.darkText : Colors.black,
                ),
              ),
              const SizedBox(width: 12),
              Switch(
                value: isDark,
                activeThumbColor: AppColors.green,
                activeTrackColor: AppColors.lavender,
                onChanged: (_) {
                  Navigator.pop(context);
                  ref.read(themeProvider.notifier).toggle(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
