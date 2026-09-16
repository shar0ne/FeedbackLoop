import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:feedback_loop/presentation/providers/idea_provider.dart';
import 'package:feedback_loop/presentation/providers/profile_provider.dart';
import 'package:feedback_loop/presentation/widgets/app_bar_custom.dart';
import 'package:feedback_loop/presentation/widgets/stat_card_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showUserIdeasRating(BuildContext context, WidgetRef ref, bool isDark) {
    final ideas = ref.read(ideaListProvider).value ?? [];
    final myIdeas =
        ideas.where((idea) => idea.authorName == 'Deb Josh').toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notes de mes idées',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: isDark ? AppColors.darkText : Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: isDark ? AppColors.darkText : Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (myIdeas.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Vous n’avez pas encore soumis d’idées.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )
              else
                ...myIdeas.map(
                  (idea) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      idea.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkText : Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      '${idea.voteCount} votes',
                      style: TextStyle(
                        color: isDark ? AppColors.darkSubtext : Colors.black54,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.starYellow,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          idea.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    final userAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: const AppBarCustom(
        title: 'Mon profil',
      ),
      body: userAsync.when(
        data: (user) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // User Header Row
                Row(
                  children: [
                    // Large Circular Avatar
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: AppColors.mintGreen,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        user.initial,
                        style: const TextStyle(
                          fontSize: 48,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Name & Role & Logout
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.darkText : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user.role,
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: isDark
                                  ? AppColors.darkSubtext
                                  : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Déconnexion effectuée.',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              minimumSize: const Size(0, 32),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Se déconnecter',
                              style: TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Big Points Card
                StatCardCustom(
                  title: 'Point(s)',
                  value: '${user.points}',
                  description: 'Une idée équivaut à 50 points',
                  isLarge: true,
                ),

                const SizedBox(height: 20),

                // Likes & Dislikes row
                Row(
                  children: [
                    StatCardCustom(
                      title: 'Like(s)',
                      value: '${user.likes}',
                      description: 'Un like correspond\nà un point',
                      isLarge: false,
                    ),
                    const SizedBox(width: 16),
                    StatCardCustom(
                      title: 'Dislike(s)',
                      value: '${user.dislikes}',
                      description: 'Cinq dislikes coupent\nun point',
                      isLarge: false,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // "Voir la note de mes idées" Button
                ElevatedButton(
                  onPressed: () =>
                      _showUserIdeasRating(context, ref, isDark),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    minimumSize: const Size(0, 44),
                  ),
                  child: const Text(
                    'Voir la note de mes idées',
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Erreur de chargement du profil',
            style: TextStyle(
              color: isDark ? AppColors.darkText : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
