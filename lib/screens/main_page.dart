import 'package:flutter/material.dart';
import 'package:frontend/component/sensors_dashboard.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset('assets/images/logo.jpg'),
      const Expanded(child: SensorsDashboard()),
    ],);
  }
}
