import 'package:feedback_loop/data/data_source/mock_idea_data_source.dart';
import 'package:feedback_loop/domain/entities/comment_entity.dart';
import 'package:feedback_loop/domain/entities/idea_entity.dart';
import 'package:feedback_loop/domain/repositories/idea_repository.dart';

class IdeaRepositoryImpl implements IdeaRepository {
  final MockIdeaDataSource dataSource;

  IdeaRepositoryImpl({required this.dataSource});

  @override
  Future<List<IdeaEntity>> getIdeas() {
    return dataSource.getIdeas();
  }

  @override
  Future<IdeaEntity> createIdea({
    required String title,
    required String description,
    String? imageUrl,
  }) {
    return dataSource.createIdea(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }

  @override
  Future<void> voteIdea({
    required String ideaId,
    required double rating,
  }) {
    return dataSource.voteIdea(
      ideaId: ideaId,
      rating: rating,
    );
  }

  @override
  Future<List<CommentEntity>> getComments(String ideaId) {
    return dataSource.getComments(ideaId);
  }

  @override
  Future<void> addComment({
    required String ideaId,
    required String content,
    required double rating,
  }) {
    return dataSource.addComment(
      ideaId: ideaId,
      content: content,
      rating: rating,
    );
  }
}
