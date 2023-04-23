import 'package:intl/intl.dart';
class User {
  final String userId;
  final String name;
  final String plan;
  final String email;
  final DateTime birthdate;
  final double weight;
  final double height;
  final String role;

  User({
    required this.userId,
    required this.name,
    required this.plan,
    required this.email,
    required this.birthdate,
    required this.weight,
    required this.height,
    required this.role,
  });

  static User fromMap(Map<String, dynamic> data) {
    return User(
      userId: data['id'],
      name: data['name'],
      plan: data['plan'],
      email: data['email'],
      birthdate: DateTime.parse(data['birthdate']),
      weight: data['weight'],
      height: data['height'],
      role: data['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'name': name,
      'plan': plan,
      'email': email,
      'birthdate': DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(birthdate),
      'weight': weight,
      'height': height,
    };
  }
}
