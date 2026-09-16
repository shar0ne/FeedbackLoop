import 'package:feedback_loop/data/data_source/mock_user_data_source.dart';
import 'package:feedback_loop/domain/entities/user_entity.dart';
import 'package:feedback_loop/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final MockUserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<UserEntity> getCurrentUser() {
    return dataSource.getCurrentUser();
  }
}
