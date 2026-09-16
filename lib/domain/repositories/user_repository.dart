import 'package:feedback_loop/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getCurrentUser();
}
