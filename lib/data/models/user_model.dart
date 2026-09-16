import 'package:feedback_loop/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.role,
    required super.initial,
    required super.points,
    required super.likes,
    required super.dislikes,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      initial: json['initial'] as String,
      points: (json['points'] as num).toInt(),
      likes: (json['likes'] as num).toInt(),
      dislikes: (json['dislikes'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'initial': initial,
      'points': points,
      'likes': likes,
      'dislikes': dislikes,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      role: entity.role,
      initial: entity.initial,
      points: entity.points,
      likes: entity.likes,
      dislikes: entity.dislikes,
    );
  }
}
