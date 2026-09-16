import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:feedback_loop/presentation/providers/idea_provider.dart';
import 'package:feedback_loop/presentation/widgets/app_bar_custom.dart';
import 'package:feedback_loop/presentation/widgets/idea_card_custom.dart';
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
    final ideasAsync = ref.watch(ideaListProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: const AppBarCustom(
        title: 'FeedbackLoop',
        isHome: true,
      ),
      body: ideasAsync.when(
        data: (ideas) {
          if (ideas.isEmpty) {
            return Center(
              child: Text(
                'Aucune idée pour le moment.\nSoyez le premier à en proposer !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: isDark ? AppColors.darkSubtext : Colors.black54,
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => ref.read(ideaListProvider.notifier).refresh(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: ideas.length,
              separatorBuilder: (context, index) => Divider(
                color: isDark ? AppColors.darkBorder : Colors.black12,
                thickness: 1,
                indent: 14,
                endIndent: 14,
              ),
              itemBuilder: (context, index) {
                return IdeaCardCustom(idea: ideas[index]);
              },
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Une erreur est survenue lors du chargement des idées.',
                style: TextStyle(
                  color: isDark ? AppColors.darkText : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.read(ideaListProvider.notifier).refresh(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}