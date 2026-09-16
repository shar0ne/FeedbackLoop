class CommentEntity {
  final String id;
  final String ideaId;
  final String authorName;
  final String authorInitial;
  final String timeAgo;
  final double rating;
  final String content;

  const CommentEntity({
    required this.id,
    required this.ideaId,
    required this.authorName,
    required this.authorInitial,
    required this.timeAgo,
    required this.rating,
    required this.content,
  });

  CommentEntity copyWith({
    String? id,
    String? ideaId,
    String? authorName,
    String? authorInitial,
    String? timeAgo,
    double? rating,
    String? content,
  }) {
    return CommentEntity(
      id: id ?? this.id,
      ideaId: ideaId ?? this.ideaId,
      authorName: authorName ?? this.authorName,
      authorInitial: authorInitial ?? this.authorInitial,
      timeAgo: timeAgo ?? this.timeAgo,
      rating: rating ?? this.rating,
      content: content ?? this.content,
    );
  }
}
