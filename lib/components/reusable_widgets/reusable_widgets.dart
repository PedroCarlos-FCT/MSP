import 'package:flutter/material.dart';


Card reusableUserInfo(BuildContext context, TextEditingController text, IconData icon, {required Null Function(dynamic value) onChanged}) {
  final width = MediaQuery.of(context).size.width;
  return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: width *0.35, vertical: 7),
      child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: TextField(
            controller: text,
            decoration: InputDecoration(
                border: InputBorder.none
            ),
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) {
              onChanged(value);
            },
          )
      )
  );
}

Card reusableUserEmail(BuildContext context, String text, IconData icon) {
  final width = MediaQuery.of(context).size.width;
  return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: width *0.35, vertical: 7),
      child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
      )
  );
}





