import 'package:feedback_loop/data/models/user_model.dart';

class MockUserDataSource {
  UserModel _currentUser = const UserModel(
    id: 'user_1',
    name: 'Deb Josh',
    role: "Passionné d'informatique",
    initial: 'D',
    points: 50,
    likes: 38,
    dislikes: 9,
  );

  Future<UserModel> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _currentUser;
  }

  Future<void> updateUser(UserModel user) async {
    _currentUser = user;
  }
}
