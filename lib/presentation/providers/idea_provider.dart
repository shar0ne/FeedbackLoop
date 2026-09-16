import 'package:feedback_loop/data/data_source/mock_idea_data_source.dart';
import 'package:feedback_loop/data/repositories/idea_repository_impl.dart';
import 'package:feedback_loop/domain/entities/comment_entity.dart';
import 'package:feedback_loop/domain/entities/idea_entity.dart';
import 'package:feedback_loop/domain/repositories/idea_repository.dart';
import 'package:feedback_loop/domain/usecases/create_idea_usecase.dart';
import 'package:feedback_loop/domain/usecases/get_ideas_usecase.dart';
import 'package:feedback_loop/domain/usecases/vote_idea_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Data source & Repository providers
final mockIdeaDataSourceProvider = Provider<MockIdeaDataSource>((ref) {
  return MockIdeaDataSource();
});

final ideaRepositoryProvider = Provider<IdeaRepository>((ref) {
  final dataSource = ref.watch(mockIdeaDataSourceProvider);
  return IdeaRepositoryImpl(dataSource: dataSource);
});

// Use case providers
final getIdeasUseCaseProvider = Provider<GetIdeasUseCase>((ref) {
  final repo = ref.watch(ideaRepositoryProvider);
  return GetIdeasUseCase(repo);
});

final createIdeaUseCaseProvider = Provider<CreateIdeaUseCase>((ref) {
  final repo = ref.watch(ideaRepositoryProvider);
  return CreateIdeaUseCase(repo);
});

final voteIdeaUseCaseProvider = Provider<VoteIdeaUseCase>((ref) {
  final repo = ref.watch(ideaRepositoryProvider);
  return VoteIdeaUseCase(repo);
});

// Ideas State Notifier
final ideaListProvider =
    AsyncNotifierProvider<IdeaListNotifier, List<IdeaEntity>>(
  IdeaListNotifier.new,
);

class IdeaListNotifier extends AsyncNotifier<List<IdeaEntity>> {
  @override
  Future<List<IdeaEntity>> build() async {
    final useCase = ref.watch(getIdeasUseCaseProvider);
    return useCase();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getIdeasUseCaseProvider);
      return useCase();
    });
  }

  Future<void> vote(String ideaId, double rating) async {
    final voteUseCase = ref.read(voteIdeaUseCaseProvider);
    await voteUseCase(ideaId: ideaId, rating: rating);
    final getUseCase = ref.read(getIdeasUseCaseProvider);
    final updated = await getUseCase();
    state = AsyncValue.data(updated);
  }

  Future<bool> createIdea({
    required String title,
    required String description,
    String? imageUrl,
  }) async {
    try {
      final createUseCase = ref.read(createIdeaUseCaseProvider);
      await createUseCase(
        title: title,
        description: description,
        imageUrl: imageUrl,
      );
      final getUseCase = ref.read(getIdeasUseCaseProvider);
      final updated = await getUseCase();
      state = AsyncValue.data(updated);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<CommentEntity>> getComments(String ideaId) async {
    final repo = ref.read(ideaRepositoryProvider);
    return repo.getComments(ideaId);
  }

  Future<void> addComment({
    required String ideaId,
    required String content,
    required double rating,
  }) async {
    final repo = ref.read(ideaRepositoryProvider);
    await repo.addComment(ideaId: ideaId, content: content, rating: rating);
    final getUseCase = ref.read(getIdeasUseCaseProvider);
    final updated = await getUseCase();
    state = AsyncValue.data(updated);
  }
}
