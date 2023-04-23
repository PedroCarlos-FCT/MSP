import 'package:flutter/material.dart';
import 'package:frontend/models/class_info.dart';
import 'package:frontend/services/api.dart';
import 'package:frontend/services/api.dart';
import 'package:frontend/configuration/globals.dart' as globals;
import 'package:http/http.dart' as http;

class AdminCreateClass extends StatefulWidget {
  const AdminCreateClass({Key? key}) : super(key: key);

  @override
  _AdminCreateClassState createState() => _AdminCreateClassState();
}

class _AdminCreateClassState extends State<AdminCreateClass> {
  APIService apiService = APIService.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  //max users
  final TextEditingController _maxUsersController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();
  final TextEditingController _gymRoomController = TextEditingController();
  String? selectedClass;
  DateTime? selectedDate;
  String? selectedTime;

  List<String> classes = ['Yoga', 'Pilates', 'Zumba', 'Spin'];

  List<String> availableTimes = ['10:00 AM', '11:00 AM', '2:00 PM', '5:00 PM'];

  void _addClass() async {
    if (_formKey.currentState!.validate() && selectedDate != null) {
      ClassInfo classCreated = ClassInfo(
          name: _nameController.text,
          dateTime: selectedDate!,
          duration: int.parse(_durationController.text),
          instructor: _instructorController.text,
          gymRoom: _gymRoomController.text,
          description: _descriptionController.text,
          classId: '0',
          maxUsers: int.parse(_maxUsersController.text));
      http.Response response = await apiService.createClass(
          classCreated, globals.currentUser.userId);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          _nameController.clear();
          _descriptionController.clear();
          _durationController.clear();
          _maxUsersController.clear();
          _instructorController.clear();
          _gymRoomController.clear();
          selectedClass = null;
          selectedDate = null;
          selectedTime = null;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Class created'),
                content: const Text('The class has been created successfully'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  )
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('There was an error creating the class'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  )
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Add a class',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: 'Class name',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name for the class';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: 'Class description',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description for the class';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Please select a date:',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 8.0),
            _buildDateTimePicker(),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: 'Duration',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a duration for the class';
                  }

                  int? duration = int.tryParse(value);
                  if (duration == null) {
                    return 'Please enter a valid integer for the duration';
                  }

                  return null;
                },
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _maxUsersController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: 'Maximum users',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a maximum number of users for the class';
                  }

                  int? maxUsers = int.tryParse(value);
                  if (maxUsers == null) {
                    return 'Please enter a valid integer for the maximum number of users';
                  }

                  return null;
                },
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _instructorController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: 'Instructor',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an instructor for the class';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _gymRoomController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: 'Gym room',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a gym room for the class';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addClass,
              child: const Text('Add Class'),
            ),
          ],
        ),
      ),
    );

    /*caffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedClass = classes[index];
                        selectedDate = null;
                        selectedTime = null;
                      });
                    },
                    child: Container(
                      height: 130,
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      color: selectedClass == classes[index] ? Colors.blue : Colors.blue[100],
                      child: Padding(
                        padding: const EdgeInsets.only(top:25),
                        child: Text(
                          classes[index],
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
                    Text('Add a class', style: TextStyle(fontSize: 40),),
                    const SizedBox(height: 16.0),
                    Text(
                        'Please select a date:',
                        style: TextStyle(fontSize: 25)
                    ),
                    const SizedBox(height: 8.0),
                    _buildDateTimePicker(),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        _bookClass(selectedClass!, selectedDate, selectedTime);
                      },
                      child: const Text('Add Class',         style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Divider(),
                    Text(
                      'This subject has the following classes:',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );*/
  }

  Widget _buildDateTimePicker() {
    return ElevatedButton(
      onPressed: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );

        if (pickedDate != null) {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (pickedTime != null) {
            setState(() {
              selectedDate = DateTime(pickedDate.year, pickedDate.month,
                  pickedDate.day, pickedTime.hour, pickedTime.minute);
            });
          }
        }
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(200, 60),
        ),
      ),
      child: Text(
        selectedDate == null
            ? 'Select Date and Time'
            : 'Selected Date and Time: ${selectedDate}',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  void _bookClass(
      String className, DateTime? selectedDate, String? selectedTime) {
    if (selectedDate == null) {
      return;
    }
    // TODO: implement booking logic

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Class added'),
          content: Text(
              'You have successfully created a $className class on ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
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
