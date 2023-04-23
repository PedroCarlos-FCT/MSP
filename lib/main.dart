import 'package:flutter/material.dart';
import 'package:frontend/screens/PersonalSchedule.dart';
import 'package:frontend/screens/main_page.dart';

import 'package:frontend/configuration/globals.dart' as globals;
import 'package:frontend/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'component/login.dart';
import 'models/user.dart';
import 'firebase_options.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightBlue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({required String title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: globals.isUserInitialized ? Row(
          children: [
            /*
            Image.asset(
              'assets/images/logo.jpg',
              height: 60,
              width: 90,
            ),
            Spacer(),*/
            Container(
              width: 500,
              child: TabBar(
                labelColor: Color.fromRGBO(4, 2, 46, 1),
                labelStyle: theme.textTheme.displayLarge,
                indicatorWeight: 0.00000000001,
                indicatorColor: Color.fromRGBO(4, 2, 46, 1),
                unselectedLabelColor: Color.fromRGBO(4, 2, 46, 0.7),
                controller: tabController,
                tabs: [
                  Container(
                    margin: const EdgeInsets.only(right: 60),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        height: 60,
                        width: 90,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(
                      child: Text(
                        'Classes',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(
                      child: Text(
                        'Subscription',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            LoginComponent(
              isLoggedIn: false,
              user: User(userId: '12', name: 'Pedro Coelho', plan: 'Pobre', email: 'ptmc2000@gmail.com', birthdate: DateTime.now(), weight: 0, height: 0, role: 'user'),
            ),
          ],
        ) : Text("Login"),
      ),
      body: globals.isUserInitialized ? Container(

        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            MainPage(),
            PersonalSchedule(),
            Container(
              color: Colors.orange,
            ),
          ],
        ),
      ) : SignInScreen(),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
