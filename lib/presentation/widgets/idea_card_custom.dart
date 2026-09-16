import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:feedback_loop/domain/entities/idea_entity.dart';
import 'package:feedback_loop/presentation/widgets/comments_bottom_sheet_custom.dart';
import 'package:feedback_loop/presentation/widgets/vote_dialog_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

class IdeaCardCustom extends ConsumerWidget {
  final IdeaEntity idea;

  const IdeaCardCustom({
    super.key,
    required this.idea,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar circle with border
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.mintGreen,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  idea.authorInitial,
                  style: const TextStyle(
                    fontSize: 26,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Name & Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      idea.authorName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkText : Colors.black,
                      ),
                    ),
                    Text(
                      idea.authorRole,
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: isDark ? AppColors.darkSubtext : Colors.black87,
                      ),
                    ),
                    Text(
                      idea.timeAgo,
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: isDark ? AppColors.darkSubtext : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              // "Voir ses autres idées" button
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Autres idées de ${idea.authorName}',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Voir ses autres idées',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Description with ReadMore
          ReadMoreText(
            idea.description,
            trimLines: 3,
            colorClickableText: AppColors.primary,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Lire plus',
            trimExpandedText: ' Réduire',
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: isDark ? AppColors.darkText : Colors.black87,
              height: 1.3,
            ),
            moreStyle: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
            lessStyle: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),

          // Idea Image placeholder
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lavender,
              borderRadius: BorderRadius.circular(16),
            ),
            child: idea.imageUrl != null && idea.imageUrl!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      idea.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 10),

          // Footer Action Row
          Row(
            children: [
              // Rating star + value
              Icon(
                Icons.star,
                color: AppColors.starYellow,
                size: 20,
              ),
              const SizedBox(width: 2),
              Text(
                '•${idea.rating.toStringAsFixed(1)}',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '|',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppColors.darkBorder : Colors.black26,
                ),
              ),
              const SizedBox(width: 8),

              // Votes count
              GestureDetector(
                onTap: () => VoteResultsDialogCustom.show(context, idea),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: isDark ? AppColors.darkText : Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: '${idea.voteCount} ',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: 'ont votés'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '|',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppColors.darkBorder : Colors.black26,
                ),
              ),
              const SizedBox(width: 8),

              // Comments icon + count
              GestureDetector(
                onTap: () => CommentsBottomSheetCustom.show(context, idea),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${idea.commentCount}',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkText : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Vote / Voir les votes button
              ElevatedButton(
                onPressed: () {
                  if (idea.hasVoted) {
                    VoteResultsDialogCustom.show(context, idea);
                  } else {
                    VoteDialogCustom.show(context, idea);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  idea.hasVoted ? 'Voir les votes' : 'Voter',
                  style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
