import 'package:flutter/material.dart';
import 'package:frontend/reusable_widgets/reusable_widget.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/reset_password.dart';
import 'package:frontend/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/configuration/globals.dart' as globals;
import 'package:frontend/services/api.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  APIService apiService = APIService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 2, 77, 137),
          Color.fromARGB(255, 106, 185, 249)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                400, MediaQuery.of(context).size.height * 0.2, 400, 0),
            child: Column(
              children: <Widget>[
                Icon(Icons.person, size: 100),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    /*Button(context, Colors.blue.shade400,
                        'Continue with Facebook', () {}),
                  ],
                ),
                Column(
                  children: [
                    Button(context, Colors.blue.shade400,
                        'Continue with Google', () {})
                  ],
                ),
                const SizedBox(height: 20),*/
                    reusableText("Enter UserName", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableText("Enter Password", Icons.lock_outline, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 5,
                    ),/*
                    forgetPassword(context),*/
                    Button(context, Colors.white, "Sign In", () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text )
                          .then((value) {
                        apiService
                            .fetchUser(userId: value.user!.uid)
                            .then((value) => setState(() {
                                  globals.currentUser = value;
                                  globals.isUserInitialized = true;
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(
                                                title: '',
                                              )));
                                }));
                        //replace with home screen
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    }),
                    signUpOption()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}
