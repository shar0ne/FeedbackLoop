import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:feedback_loop/domain/entities/comment_entity.dart';
import 'package:feedback_loop/domain/entities/idea_entity.dart';
import 'package:feedback_loop/presentation/providers/idea_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentsBottomSheetCustom extends ConsumerStatefulWidget {
  final IdeaEntity idea;

  const CommentsBottomSheetCustom({
    super.key,
    required this.idea,
  });

  static Future<void> show(BuildContext context, IdeaEntity idea) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentsBottomSheetCustom(idea: idea),
    );
  }

  @override
  ConsumerState<CommentsBottomSheetCustom> createState() =>
      _CommentsBottomSheetCustomState();
}

class _CommentsBottomSheetCustomState
    extends ConsumerState<CommentsBottomSheetCustom> {
  final TextEditingController _commentController = TextEditingController();
  List<CommentEntity> _comments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    final comments = await ref
        .read(ideaListProvider.notifier)
        .getComments(widget.idea.id);
    if (mounted) {
      setState(() {
        _comments = comments;
        _isLoading = false;
      });
    }
  }

  Future<void> _sendComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    await ref.read(ideaListProvider.notifier).addComment(
          ideaId: widget.idea.id,
          content: text,
          rating: 4.0,
        );

    _commentController.clear();
    await _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Top pill drag handle
          Container(
            width: 48,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.lavender,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Commentaires (${_comments.length})',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: isDark ? AppColors.darkText : Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: isDark ? AppColors.darkText : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 24),
          // Comments list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _comments.isEmpty
                    ? Center(
                        child: Text(
                          'Aucun commentaire pour le moment.\nSoyez le premier à donner votre avis !',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: isDark
                                ? AppColors.darkSubtext
                                : Colors.black45,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        itemCount: _comments.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final comment = _comments[index];
                          return _CommentTile(
                            comment: comment,
                            isDark: isDark,
                          );
                        },
                      ),
          ),
          // Bottom input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.darkBorder : Colors.black12,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.lavender,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.5),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'D',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: TextField(
                      controller: _commentController,
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: isDark ? AppColors.darkText : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Donner un avis',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: isDark
                              ? AppColors.darkSubtext
                              : Colors.black45,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onSubmitted: (_) => _sendComment(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendComment,
                  icon: const Icon(
                    Icons.send_rounded,
                    color: AppColors.primary,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final CommentEntity comment;
  final bool isDark;

  const _CommentTile({
    required this.comment,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.lavender,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              alignment: Alignment.center,
              child: Text(
                comment.authorInitial,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.authorName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkText : Colors.black87,
                    ),
                  ),
                  Text(
                    comment.timeAgo,
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: isDark ? AppColors.darkSubtext : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: List.generate(5, (i) {
                final isFull = (i + 1) <= comment.rating.round();
                return Icon(
                  Icons.star,
                  size: 16,
                  color: isFull
                      ? AppColors.starYellow
                      : (isDark ? Colors.white24 : AppColors.lavender),
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          comment.content,
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: isDark ? AppColors.darkText : Colors.black87,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
