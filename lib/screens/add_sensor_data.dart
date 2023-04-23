             
import 'package:flutter/material.dart';
import 'package:frontend/models/fitness_session.dart';
import 'package:frontend/services/api.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:frontend/configuration/globals.dart' as globals;
import 'package:http/http.dart' as http;



class AddSensorDataScreen extends StatefulWidget {
  const AddSensorDataScreen({Key? key}) : super(key: key);

  @override
  State<AddSensorDataScreen> createState() => _AddSensorDataScreenState();
}

class _AddSensorDataScreenState extends State<AddSensorDataScreen> {
  String machineSelected = "Treadmill";
  DateTime startTime = DateTime.now();
  bool isDateSelected = false;
  bool isTimeSelected = false;
  int duration = 0;
  APIService apiService = APIService.instance;

  @override
  Widget build(BuildContext context) {
    List<String> machines = ["Treadmill", "Elliptical", "Leg press", "Pulley"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Sensor Data"),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 600,
          decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                        "Select the machine to which you want to add metrics:"),
                SizedBox(width:10),
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                        width: 3,
                      )),

                  child: DropdownButton<String>(
                    value: machineSelected,
                    items: machines.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        machineSelected = value!;
                      });
                    },
                    // add extra sugar..
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 25,
                    underline: SizedBox(),
                  ),
                )
                  ],
                ),
              ),
              SizedBox(height: 15,),
              TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: startTime,
                    firstDate: DateTime(2023),
                    lastDate: DateTime.now(),
                  ).then((value) {
                    setState(() {
                      startTime = value!;
                      isDateSelected = true;
                    });
                  });
                },
                child: isDateSelected
                    ? Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),),
                      child: Text(
                          "Selected day: ${DateFormat('dd-MM-yyyy').format(startTime)}"),
                    )
                    : Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),),
                    child: const Text("Select the day to insert metrics")),
              ),
              //button to select time
             SizedBox(height: 15,),
              TextButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(startTime),
                  ).then((value) {
                    setState(() {
                      startTime = DateTime(
                        startTime.year,
                        startTime.month,
                        startTime.day,
                        value!.hour,
                        value.minute,
                      );
                      isTimeSelected = true;
                    });
                  });
                },
                child: isTimeSelected
                    ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),),
                          child: Text(
                              "Selected hour ${DateFormat('kk:mm').format(startTime)}"),
                        ),
                      ],
                    )
                    : Container(padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),),
                    child: const Text("Select hour to insert metrics")),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Duration of the exercise in minutes: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                    child: SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            if (value == "") {
                              value = "0";
                            }
                            duration = int.parse(value);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              isAfterNow()
                  ? const Center(
                      child: Text(
                        "The exercise duration cannot be longer than the current time, enter another duration or another exercise start",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SizedBox(),
              InkWell(
                onTap: () {
                  addData();
                  //add data to database
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: isAfterNow()
                      ? BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                        )
                      : BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                  child: const Center(
                    child: Text(
                      "Add data",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isAfterNow() {
    return duration != 0 &&
        isDateSelected &&
        isTimeSelected &&
        startTime.add(Duration(minutes: duration)).isAfter(DateTime.now());
  }

  Future<void> addData() async {
    final random = Random();
    final metric = duration * ((random.nextInt(20)) + 1);
    final calories = duration * (random.nextInt(10) + 1) * 50;

    if (isAfterNow()) {
      var snackBar = SnackBar(content: Text('Please insert a valid date and duration of exercice'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return; //do not execute if conditions are not met
    } else if (duration <= 0 || !isDateSelected || !isTimeSelected) {
      var snackBar = SnackBar(content: Text('Please insert all values'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else {
      http.Response response = await apiService.createFitnessSession(
          FitnessSession(initialTime: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(startTime), id: 0, finalTime: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(startTime.add(Duration(minutes: duration))), userId: globals.currentUser.userId, metric: metric, machineUsed: machineSelected, calories: calories),
          globals.currentUser.userId
      );
      if(response.statusCode != 200){
        var snackBar = SnackBar(content: Text('Error adding data'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      var snackBar = SnackBar(content: Text('Data added sucessfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    //TODO add data to database
  }
}
