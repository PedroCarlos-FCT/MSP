import 'package:flutter/material.dart';
import 'package:frontend/component/prizes_ranking.dart';
import 'package:frontend/models/heartbeat_data.dart';
import 'package:frontend/models/user_ranking.dart';
import 'package:frontend/screens/add_sensor_data.dart';
import 'package:frontend/services/api.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:frontend/configuration/globals.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SensorsDashboard extends StatefulWidget {
  const SensorsDashboard({Key? key}) : super(key: key);

  @override
  State<SensorsDashboard> createState() => _SensorsDashboardState();
}

class _SensorsDashboardState extends State<SensorsDashboard>
    with TickerProviderStateMixin {
  late TabController _controller;
  late TabController _controllerRanking;
  List<ContentConfig> listContentConfig = [];
  APIService apiService = APIService.instance;
  DateTime selectedDate = DateTime(2020, 1, 14);
  late Future<Map<String, List<UserRanking>>> rankings;

  final List<HeartbeatData> chartData = [
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 10)), heartbeat: 80),
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 9)), heartbeat: 81),
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 8)), heartbeat: 82),
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 7)), heartbeat: 84),
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 6)), heartbeat: 86),
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 5)), heartbeat: 85),
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 4)), heartbeat: 83),
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 3)), heartbeat: 82),
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 2)), heartbeat: 79),
    HeartbeatData(
        time: DateTime.now().subtract(Duration(seconds: 1)), heartbeat: 77),
    HeartbeatData(time: DateTime.now(), heartbeat: 78),
  ];

  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  bool _predicate(DateTime day) {
    if ((day.isAfter(DateTime(2020, 1, 5)) &&
        day.isBefore(DateTime(2020, 1, 9)))) {
      return true;
    }

    if ((day.isAfter(DateTime(2020, 1, 10)) &&
        day.isBefore(DateTime(2020, 1, 15)))) {
      return true;
    }
    if ((day.isAfter(DateTime(2020, 2, 5)) &&
        day.isBefore(DateTime(2020, 2, 17)))) {
      return true;
    }

    return false;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        selectableDayPredicate: _predicate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2021),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
                primaryColor: Colors.orangeAccent,
                disabledColor: Colors.brown,
                textTheme:
                    TextTheme(bodyText1: TextStyle(color: Colors.blueAccent)),
                accentColor: Colors.yellow),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
    data = [
      _ChartData('Passadeira', 180),
      _ChartData('Elíptica', 130),
      _ChartData('Remo', 90),
    ];
    _tooltip = TooltipBehavior(enable: true);
    print('Before calling fetchUserRankingMap');
    rankings = apiService.fetchUserRankingMap(
      userId: '1681662152172',
    );
    rankings.then((value) => setState(() {
          _controllerRanking = TabController(length: value.length, vsync: this);
        }));
    _controller = TabController(length: 2, vsync: this);
    _controllerRanking = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(color: Colors.blue[400]),
                child: FutureBuilder<Map<String, List<UserRanking>>>(
                  future: rankings,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Tab> tabs = snapshot.data!.keys.map((key) {
                        return Tab(icon: iconAccordingToText(key), text: key);
                      }).toList();
                      return TabBar(
                        controller: _controllerRanking,
                        tabs: tabs,
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder<Map<String, List<UserRanking>>>(
                  future: rankings,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return TabBarView(
                          controller: _controllerRanking,
                          children: snapshot.data!.keys.map((key) {
                            return PrizesRanking(
                                machineSelected: key,
                                rankings: snapshot.data![key]!);
                          }).toList());
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Text('Obtaining rankings...');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (() => {
                        //navigate to add sensor data screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddSensorDataScreen()),
                        )
                      }),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(color: Colors.blue[200]!, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.indigo[900],
                          size: 25,
                        ),
                        Text(
                          "Adicionar métricas",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget iconAccordingToText(String key) {
    if (key.toLowerCase() == "passadeira") {
      return Icon(Icons.directions_run);
    } else if (key.toLowerCase() == "bike") {
      return Icon(Icons.directions_bike);
    } else if (key.toLowerCase() == "leg press") {
      return FaIcon(FontAwesomeIcons.dumbbell);
    } else if (key.toLowerCase() == "pulley") {
      return Icon(Icons.directions_walk);
    } else if (key.toLowerCase() == "calories") {
      return FaIcon(FontAwesomeIcons.fire);
    } else {
      return const FaIcon(FontAwesomeIcons.dumbbell);
    }
  }

  String keyToMachine(String key) {
    if (key.toLowerCase() == "passadeira") {
      return "Passadeira";
    } else if (key.toLowerCase() == "bike") {
      return "Elíptica";
    } else if (key.toLowerCase() == "leg press") {
      return "Leg press";
    } else if (key.toLowerCase() == "pulley") {
      return "Pulley";
    } else if (key.toLowerCase() == "calories") {
      return "Calorias";
    } else {
      return key;
    }
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
