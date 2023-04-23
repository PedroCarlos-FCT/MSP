import 'package:flutter/material.dart';
import 'package:frontend/models/class_info.dart';
import 'package:intl/intl.dart';
class UserClasses extends StatelessWidget {
    final List<ClassInfo> classes; 


  UserClasses({required this.classes});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white54),
      columns: [
        DataColumn(label: Text('Class')),
        DataColumn(label: Text('DateTime')),
        DataColumn(label: Text('Duration')),
        DataColumn(label: Text('Instructor')),
        DataColumn(label: Text('Gym Room')),
      ],
      rows:
          classes
              .map(
                ((element) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(element.name)),
                        DataCell(Text(DateFormat('yyyy-MM-dd HH:mm').format(element.dateTime))),
                        DataCell(Text(element.duration.toString())),
                        DataCell(Text(element.instructor)),
                        DataCell(Text(element.gymRoom.toString())),

                      ],
                    )),
              )
              .toList(),
    );
  }
}


  

