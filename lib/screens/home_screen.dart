import 'package:flutter/material.dart';
import 'package:frontend/screens/UserBookClassPage.dart';
import 'package:frontend/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/PersonalSchedule.dart';
import 'package:frontend/screens/main_page.dart';

import 'package:frontend/configuration/globals.dart' as globals;
import 'package:frontend/component/login.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/screens_admin/AdminCreateClass.dart';
import 'package:frontend/screens_admin/subscription_admin.dart';
import 'package:frontend/screens_user/subscription_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required String title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  User user = globals.currentUser;
  bool isLoggedIn = globals.isUserInitialized;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Row(
          children: [
            /*
            Image.asset(
              'assets/images/logo.jpg',
              height: 60,
              width: 90,
            ),
            Spacer(),*/
            Container(
              width: 700,
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
                        'Personal schedule',
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
            isLoggedIn ? LoginComponent(
              isLoggedIn: isLoggedIn,
              user: user,
            ) : SizedBox(),
          ],
        )
      ),
      body: Container(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            MainPage(),
            globals.currentUser.role != "admin" ? UserBookClassPage() : AdminCreateClass(),
            PersonalSchedule(),
            globals.currentUser.role != "admin" ? SubscriptionUser() : SubscriptionAdmin(),
          ],
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:frontend/screens/PersonalSchedule.dart';
import 'package:frontend/screens/main_page.dart';

import 'package:frontend/configuration/globals.dart' as globals;
import 'package:frontend/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'component/login.dart';
import 'models/user.dart';
import 'firebase_options.dart';*/

