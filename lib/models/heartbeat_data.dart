
class HeartbeatData {
  final DateTime time;
  final int heartbeat;

  HeartbeatData(
      {required this.time,
        required this.heartbeat});

/*Alarm.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        alarmId = json['alarmId'],
        date = json['date'],
        time = json['time'],
        annoyingAlarm = json['annoyingAlarm'],
        soundLevel = json['soundLevel'],
        useLeds = json['useLeds'],
        isOn = json['isOn'],
        everyDay = json['everyDay'],
        daysOfTheWeek = json['daysOfTheWeek'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'alarmId': alarmId,
    'date': date,
    'time': time,
    'annoyingAlarm': annoyingAlarm,
    'soundLevel': soundLevel,
    'useLeds': useLeds,
    'isOn': isOn,
    'everyDay': everyDay,
    'daysOfTheWeek': daysOfTheWeek
  };*/
}