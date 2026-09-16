import 'package:feedback_loop/domain/entities/user_entity.dart';
import 'package:feedback_loop/domain/repositories/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.getCurrentUser();
  }
}
