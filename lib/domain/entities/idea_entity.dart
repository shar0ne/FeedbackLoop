class IdeaEntity {
  final String id;
  final String authorId;
  final String authorName;
  final String authorRole;
  final String authorInitial;
  final String timeAgo;
  final String title;
  final String description;
  final String? imageUrl;
  final double rating;
  final int voteCount;
  final int commentCount;
  final bool hasVoted;
  final double? userVote;
  final Map<int, int> voteDistribution;

  const IdeaEntity({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.authorRole,
    required this.authorInitial,
    required this.timeAgo,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.rating,
    required this.voteCount,
    required this.commentCount,
    this.hasVoted = false,
    this.userVote,
    required this.voteDistribution,
  });

  IdeaEntity copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? authorRole,
    String? authorInitial,
    String? timeAgo,
    String? title,
    String? description,
    String? imageUrl,
    double? rating,
    int? voteCount,
    int? commentCount,
    bool? hasVoted,
    double? userVote,
    Map<int, int>? voteDistribution,
  }) {
    return IdeaEntity(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorRole: authorRole ?? this.authorRole,
      authorInitial: authorInitial ?? this.authorInitial,
      timeAgo: timeAgo ?? this.timeAgo,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      voteCount: voteCount ?? this.voteCount,
      commentCount: commentCount ?? this.commentCount,
      hasVoted: hasVoted ?? this.hasVoted,
      userVote: userVote ?? this.userVote,
      voteDistribution: voteDistribution ?? this.voteDistribution,
    );
  }
}
