import 'package:feedback_loop/domain/entities/idea_entity.dart';

class IdeaModel extends IdeaEntity {
  const IdeaModel({
    required super.id,
    required super.authorId,
    required super.authorName,
    required super.authorRole,
    required super.authorInitial,
    required super.timeAgo,
    required super.title,
    required super.description,
    super.imageUrl,
    required super.rating,
    required super.voteCount,
    required super.commentCount,
    super.hasVoted = false,
    super.userVote,
    required super.voteDistribution,
  });

  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    return IdeaModel(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorRole: json['authorRole'] as String,
      authorInitial: json['authorInitial'] as String,
      timeAgo: json['timeAgo'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      rating: (json['rating'] as num).toDouble(),
      voteCount: (json['voteCount'] as num).toInt(),
      commentCount: (json['commentCount'] as num).toInt(),
      hasVoted: (json['hasVoted'] as bool?) ?? false,
      userVote: (json['userVote'] as num?)?.toDouble(),
      voteDistribution: (json['voteDistribution'] as Map<String, dynamic>?)?.map(
            (k, v) => MapEntry(int.parse(k), (v as num).toInt()),
          ) ??
          {5: 0, 4: 0, 3: 0, 2: 0, 1: 0},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'authorRole': authorRole,
      'authorInitial': authorInitial,
      'timeAgo': timeAgo,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'voteCount': voteCount,
      'commentCount': commentCount,
      'hasVoted': hasVoted,
      'userVote': userVote,
      'voteDistribution': voteDistribution.map((k, v) => MapEntry(k.toString(), v)),
    };
  }

  factory IdeaModel.fromEntity(IdeaEntity entity) {
    return IdeaModel(
      id: entity.id,
      authorId: entity.authorId,
      authorName: entity.authorName,
      authorRole: entity.authorRole,
      authorInitial: entity.authorInitial,
      timeAgo: entity.timeAgo,
      title: entity.title,
      description: entity.description,
      imageUrl: entity.imageUrl,
      rating: entity.rating,
      voteCount: entity.voteCount,
      commentCount: entity.commentCount,
      hasVoted: entity.hasVoted,
      userVote: entity.userVote,
      voteDistribution: entity.voteDistribution,
    );
  }
}
