import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:feedback_loop/domain/entities/idea_entity.dart';
import 'package:feedback_loop/presentation/providers/idea_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoteDialogCustom extends ConsumerStatefulWidget {
  final IdeaEntity idea;

  const VoteDialogCustom({
    super.key,
    required this.idea,
  });

  static Future<void> show(BuildContext context, IdeaEntity idea) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => VoteDialogCustom(idea: idea),
    );
  }

  @override
  ConsumerState<VoteDialogCustom> createState() => _VoteDialogCustomState();
}

class _VoteDialogCustomState extends ConsumerState<VoteDialogCustom> {
  int _selectedRating = 4;

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return 'Pas du tout intéressante';
      case 2:
        return 'Peu intéressante';
      case 3:
        return 'Intéressante';
      case 4:
        return 'Bonne idée !';
      case 5:
        return 'Excellente idée !';
      default:
        return '';
    }
  }

  void _submitVote() {
    ref.read(ideaListProvider.notifier).vote(
          widget.idea.id,
          _selectedRating.toDouble(),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkProvider);

    return Dialog(
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isDark ? AppColors.darkBorder : Colors.black12,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  color: isDark ? AppColors.darkText : Colors.black87,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'À quel point trouvez-vous\ncette idée interessante ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkText : Colors.black87,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starNum = index + 1;
                final isFilled = starNum <= _selectedRating;
                final isCenterBigger = starNum == 3;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = starNum;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.star,
                      size: isCenterBigger ? 44 : 36,
                      color: isFilled
                          ? AppColors.starYellow
                          : (isDark ? Colors.white24 : AppColors.lavender),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(
              _getRatingLabel(_selectedRating),
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitVote,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              ),
              child: const Text(
                'Confirmer mon vote',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoteResultsDialogCustom extends ConsumerWidget {
  final IdeaEntity idea;

  const VoteResultsDialogCustom({
    super.key,
    required this.idea,
  });

  static Future<void> show(BuildContext context, IdeaEntity idea) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => VoteResultsDialogCustom(idea: idea),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    final totalVotes = idea.voteCount > 0 ? idea.voteCount : 1;

    return Dialog(
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isDark ? AppColors.darkBorder : Colors.black12,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  color: isDark ? AppColors.darkText : Colors.black87,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        idea.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final star = index + 1;
                          final isFull = star <= idea.rating.round();
                          return Icon(
                            Icons.star,
                            size: 16,
                            color: isFull
                                ? AppColors.starYellow
                                : (isDark ? Colors.white24 : AppColors.lavender),
                          );
                        }),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${idea.voteCount}',
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: isDark ? AppColors.darkSubtext : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [5, 4, 3, 2, 1].map((starLevel) {
                      final count = idea.voteDistribution[starLevel] ?? 0;
                      final ratio = (count / totalVotes).clamp(0.0, 1.0);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            Text(
                              '$starLevel',
                              style: TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color:
                                    isDark ? AppColors.darkText : Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: ratio,
                                  minHeight: 8,
                                  backgroundColor: isDark
                                      ? AppColors.darkSurface
                                      : AppColors.lavender,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    AppColors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
