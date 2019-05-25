import 'package:flutter/material.dart';
import './ui/login.dart';
import './ui/register.dart';
import './ui/mainpage.dart';
import './ui/testdb.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{ //Change screen
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(),
      initialRoute: '/',
      routes: {
        "/": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/main": (context) => MPage(),
        "/testdb": (context) => UserScreen(),
      },
    );
  }

}