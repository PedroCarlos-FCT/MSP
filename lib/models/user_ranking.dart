import 'package:frontend/models/fitness_session.dart';

class UserRanking {
  String userId;
  String username;
  FitnessSession metric;

  UserRanking({
    required this.userId,
    required this.username,
    required this.metric,
  });

  factory UserRanking.fromJson(Map<String, dynamic> json) {
    return UserRanking(
      userId: json['userId'],
      username: json['username'],
      metric: FitnessSession.fromJson(json['metric']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'metric': metric.toJson(),
    };
  }
}