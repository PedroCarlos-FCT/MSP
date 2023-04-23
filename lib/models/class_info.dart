import 'package:intl/intl.dart';
class ClassInfo {
  String name;
  DateTime dateTime;
  int duration;
  String instructor;
  String gymRoom;
  int maxUsers;
  String description;
  String classId;

  ClassInfo({required this.name, required this.dateTime, required this.duration, required this.instructor, required this.gymRoom, required this.description, required this.classId, required this.maxUsers});

  static ClassInfo fromMap(Map<String, dynamic> data) {
    return ClassInfo(
      name: data['name'],
      dateTime: DateTime.parse(data['time']),
      duration: data['duration'],
      instructor: data['instructor'],
      gymRoom: data['gymRoom'],
      description: data['description'],
      classId: data['id'].toString(),
      maxUsers: data['maxUsers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time':  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateTime),
      'duration': duration,
      'instructor': instructor,
      'gymRoom': gymRoom,
      'description': description,
      'maxUsers': maxUsers,
    };
  }
}