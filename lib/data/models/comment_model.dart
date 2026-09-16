import 'package:feedback_loop/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.id,
    required super.ideaId,
    required super.authorName,
    required super.authorInitial,
    required super.timeAgo,
    required super.rating,
    required super.content,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      ideaId: json['ideaId'] as String,
      authorName: json['authorName'] as String,
      authorInitial: json['authorInitial'] as String,
      timeAgo: json['timeAgo'] as String,
      rating: (json['rating'] as num).toDouble(),
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ideaId': ideaId,
      'authorName': authorName,
      'authorInitial': authorInitial,
      'timeAgo': timeAgo,
      'rating': rating,
      'content': content,
    };
  }

  factory CommentModel.fromEntity(CommentEntity entity) {
    return CommentModel(
      id: entity.id,
      ideaId: entity.ideaId,
      authorName: entity.authorName,
      authorInitial: entity.authorInitial,
      timeAgo: entity.timeAgo,
      rating: entity.rating,
      content: entity.content,
    );
  }
}
