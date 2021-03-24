import 'package:flutter/material.dart';
import 'package:task/Screens/login_screen.dart';
import 'package:task/Screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: RegisterScreen(),
        home: LoginScreen() //MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}
