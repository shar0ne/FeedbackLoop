import 'package:feedback_loop/data/data_source/mock_user_data_source.dart';
import 'package:feedback_loop/data/repositories/user_repository_impl.dart';
import 'package:feedback_loop/domain/entities/user_entity.dart';
import 'package:feedback_loop/domain/repositories/user_repository.dart';
import 'package:feedback_loop/domain/usecases/get_user_profile_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// User Data Source & Repository providers
final mockUserDataSourceProvider = Provider<MockUserDataSource>((ref) {
  return MockUserDataSource();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dataSource = ref.watch(mockUserDataSourceProvider);
  return UserRepositoryImpl(dataSource: dataSource);
});

final getUserProfileUseCaseProvider = Provider<GetUserProfileUseCase>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return GetUserProfileUseCase(repo);
});

// Profile State Notifier
final profileProvider =
    AsyncNotifierProvider<ProfileNotifier, UserEntity>(
  ProfileNotifier.new,
);

class ProfileNotifier extends AsyncNotifier<UserEntity> {
  @override
  Future<UserEntity> build() async {
    final useCase = ref.watch(getUserProfileUseCaseProvider);
    return useCase();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getUserProfileUseCaseProvider);
      return useCase();
    });
  }
}
