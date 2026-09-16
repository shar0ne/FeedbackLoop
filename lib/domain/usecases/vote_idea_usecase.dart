import 'package:feedback_loop/domain/repositories/idea_repository.dart';

class VoteIdeaUseCase {
  final IdeaRepository repository;

  VoteIdeaUseCase(this.repository);

  Future<void> call({
    required String ideaId,
    required double rating,
  }) {
    return repository.voteIdea(
      ideaId: ideaId,
      rating: rating,
    );
  }
}
