import 'package:feedback_loop/domain/entities/idea_entity.dart';
import 'package:feedback_loop/domain/repositories/idea_repository.dart';

class GetIdeasUseCase {
  final IdeaRepository repository;

  GetIdeasUseCase(this.repository);

  Future<List<IdeaEntity>> call() {
    return repository.getIdeas();
  }
}
