enum UserRole { instructor, student, coordinator }

class User {
  int? id;
  final String email;
  final String name;
  final UserRole role;
  final String passwordHash;

  User({
    this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.passwordHash,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      role: UserRole.values.byName(map['role']),
      passwordHash: map['password_hash'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.name,
      'password_hash': passwordHash,
    };
  }
}
