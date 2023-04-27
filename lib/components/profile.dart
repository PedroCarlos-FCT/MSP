import 'package:flutter/material.dart';
import 'package:frontend/components/profile/userClasses.dart';
import 'package:frontend/components/profile/userSubscription.dart';
import 'package:frontend/components/reusable_widgets/reusable_widgets.dart';
import 'package:frontend/models/class_info.dart';
import 'package:frontend/models/subscription.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/api.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({
    required this.user,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  bool hasChanged = false;
  APIService apiService = APIService.instance;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _weightController =
        TextEditingController(text: widget.user.weight.toString());
    _heightController =
        TextEditingController(text: widget.user.height.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.user.email;
    List<ClassInfo> classes = [];
    List<Subscription> subscriptions = [];

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 100,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _nameController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(border: InputBorder.none),
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) {
                setState(() {
                  hasChanged = true;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            reusableUserEmail(context, email, Icons.email),

            reusableUserInfo(
              context,
              _weightController,
              Icons.monitor_weight_outlined,
              onChanged: (value) {
                setState(() {
                  hasChanged = true;
                });
              },
            ),
            reusableUserInfo(
              context,
              _heightController,
              Icons.height_rounded,
              onChanged: (value) {
                setState(() {
                  hasChanged = true;
                });
              },
            ),
            //button only visible when user has changed something
            Visibility(
              visible: hasChanged,
              child: ElevatedButton(
                onPressed: () async {
                  http.Response response = await apiService.updateUser(
                    user: User(
                        userId: widget.user.userId,
                        name: _nameController.text,
                        weight: double.parse(_weightController.text),
                        height: double.parse(_heightController.text),
                        email: widget.user.email,
                        plan: widget.user.plan,
                        role: widget.user.role,
                        birthdate: widget.user.birthdate),
                  );
                  if (response.statusCode == 200)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('User updated successfully'),
                      ),
                    );
                  else
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error updating user'),
                      ),
                    );
                  setState(() {


                    hasChanged = false;
                  });
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
