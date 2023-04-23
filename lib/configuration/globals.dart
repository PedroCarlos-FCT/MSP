import 'package:frontend/models/user.dart';

User currentUser = User(userId: '', name: '', email: '', plan: '', birthdate: DateTime.now(),  weight: 0, height: 0, role: '');
bool isUserInitialized = false;
