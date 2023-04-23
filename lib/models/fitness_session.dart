class FitnessSession {
  String initialTime;
  int id;
  String finalTime;
  String userId;
  int metric;
  String machineUsed;
  int calories;

  FitnessSession({
    required this.initialTime,
    required this.id,
    required this.finalTime,
    required this.userId,
    required this.metric,
    required this.machineUsed,
    required this.calories,
  });

  factory FitnessSession.fromJson(Map<String, dynamic> json) {
    return FitnessSession(
      initialTime: json['initialTime'],
      id: json['id'],
      finalTime: json['finalTime'],
      userId: json['userId'],
      metric: json['metric'],
      machineUsed: json['machineUsed'],
      calories: json['calories'],
    );
  }

  Map<String, dynamic> toJson() => {
    'initialTime': initialTime,
    'id': id,
    'finalTime': finalTime,
    'userId': userId,
    'metric': metric,
    'machineUsed': machineUsed,
    'calories': calories,
  };
}
