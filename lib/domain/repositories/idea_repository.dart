import 'package:feedback_loop/domain/entities/comment_entity.dart';
import 'package:feedback_loop/domain/entities/idea_entity.dart';

abstract class IdeaRepository {
  Future<List<IdeaEntity>> getIdeas();
  Future<IdeaEntity> createIdea({
    required String title,
    required String description,
    String? imageUrl,
  });
  Future<void> voteIdea({
    required String ideaId,
    required double rating,
  });
  Future<List<CommentEntity>> getComments(String ideaId);
  Future<void> addComment({
    required String ideaId,
    required String content,
    required double rating,
  });
}
