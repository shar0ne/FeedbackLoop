import 'package:feedback_loop/domain/entities/idea_entity.dart';
import 'package:feedback_loop/domain/repositories/idea_repository.dart';

class CreateIdeaUseCase {
  final IdeaRepository repository;

  CreateIdeaUseCase(this.repository);

  Future<IdeaEntity> call({
    required String title,
    required String description,
    String? imageUrl,
  }) {
    return repository.createIdea(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
