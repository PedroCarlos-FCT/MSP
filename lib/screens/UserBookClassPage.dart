import 'package:flutter/material.dart';
import 'package:frontend/models/class_info.dart';
import 'package:frontend/services/api.dart';
import 'package:frontend/configuration/globals.dart' as globals;
import 'package:http/http.dart' as http;

class UserBookClassPage extends StatefulWidget {
  const UserBookClassPage({Key? key}) : super(key: key);

  @override
  _UserBookClassPageState createState() => _UserBookClassPageState();
}

class _UserBookClassPageState extends State<UserBookClassPage> {
  String? selectedClass;
  DateTime? selectedDate;
  String? selectedTime;
  String classIdSelected = '';

  APIService apiService = APIService.instance;
  late Future<Map<String, List<ClassInfo>>> classes;

  /*
  List<String> classes = ['Yoga', 'Pilates', 'Zumba', 'Spin'];

  List<String> availableTimes = ['10:00 AM', '11:00 AM', '2:00 PM', '5:00 PM'];*/

  @override
  void initState() {
    super.initState();
    classes = apiService.fetchClassInfoList(userId: globals.currentUser.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, List<ClassInfo>>>(
            future: classes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedClass =
                                      snapshot.data!.keys.elementAt(index);
                                  selectedDate = null;
                                  selectedTime = null;
                                });
                              },
                              child: Container(
                                height: 130,
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8.0),
                                color: selectedClass ==
                                        snapshot.data!.keys.elementAt(index)
                                    ? Colors.blue
                                    : Colors.blue[100],
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Text(
                                    snapshot.data!.keys.elementAt(index),
                                    style: TextStyle(fontSize: 40.0),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 1000,
                        padding: EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Book a class',
                                style: TextStyle(fontSize: 40),
                              ),
                              const SizedBox(height: 16.0),
                              Text('Please select a date:',
                                  style: TextStyle(fontSize: 25)),
                              const SizedBox(height: 8.0),
                              _buildDatePicker(),
                              const SizedBox(height: 16.0),
                              Visibility(
                                  visible: selectedDate != null,
                                  child: selectedClass != null
                                      ? _buildTimeButtons(
                                          classes:
                                              snapshot.data![selectedClass!]!)
                                      : Container()),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  _bookClass(selectedClass!, selectedDate,
                                      selectedTime);
                                },
                                child: const Text(
                                  'Book Class',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget _buildDatePicker() {
    return ElevatedButton(
      onPressed: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );

        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(200, 60),
        ),
      ),
      child: Text(
        selectedDate == null
            ? 'Select Date'
            : 'Selected Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildTimeButtons({required List<ClassInfo> classes}) {
    if (selectedDate == null) {
      return Container(); // if no date is selected, return an empty container
    }
    List<String> availableTimes = [];
    List<ClassInfo> classesOnSelectedDate = [];
    for (ClassInfo classInfo in classes) {
      DateTime classDateTime = DateTime(classInfo.dateTime.year,
          classInfo.dateTime.month, classInfo.dateTime.day);
      if (classDateTime == selectedDate) {
        classInfo.dateTime.hour < 10
            ? classInfo.dateTime.minute < 10
                ? availableTimes.add(
                    '0${classInfo.dateTime.hour}:0${classInfo.dateTime.minute}')
                : availableTimes.add(
                    '0${classInfo.dateTime.hour}:${classInfo.dateTime.minute}')
            : classInfo.dateTime.minute < 10
                ? availableTimes.add(
                    '${classInfo.dateTime.hour}:0${classInfo.dateTime.minute}')
                : availableTimes.add(
                    '${classInfo.dateTime.hour}:${classInfo.dateTime.minute}');
        classesOnSelectedDate.add(classInfo);
      }
    }
    return availableTimes.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Time Slots:',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: availableTimes.map<Widget>((time) {
                  final bool isSelected = selectedTime == time;
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedTime = isSelected ? null : time;
                        classIdSelected = isSelected
                            ? ''
                            : classesOnSelectedDate[
                                    availableTimes.indexOf(time)]
                                .classId;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isSelected ? Colors.green : Colors.grey[400],
                    ),
                    child: Text(
                      time,
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
            ],
          )
        : Text('No available time slots for this date');
  }

  void _bookClass(
      String className, DateTime? selectedDate, String? selectedTime) async {
    if (selectedDate == null || selectedTime == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Please select a date and time before booking a class.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
    http.Response response = await apiService.subscribeToClass(
        classIdSelected, globals.currentUser.userId);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Class Booked'),
            content: Text(
                'You have successfully booked a $className class on ${selectedDate!.day}/${selectedDate.month}/${selectedDate.year} at $selectedTime.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print(response.statusCode);
      print(response.body);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error has occured when booking the class.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
