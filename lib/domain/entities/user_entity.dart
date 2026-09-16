class UserEntity {
  final String id;
  final String name;
  final String role;
  final String initial;
  final int points;
  final int likes;
  final int dislikes;

  const UserEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.initial,
    required this.points,
    required this.likes,
    required this.dislikes,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? role,
    String? initial,
    int? points,
    int? likes,
    int? dislikes,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      initial: initial ?? this.initial,
      points: points ?? this.points,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
    );
  }
}
