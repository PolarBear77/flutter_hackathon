import 'package:flutter/material.dart';
import 'screen/loginPage.dart';
import 'screen/mainPage.dart';
import 'screen/signup.dart';

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
//      home: MainPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/login': (context) => LoginPage(title: 'Flutter Demo Home Page'),
        '/signUp' : (context) => SignUp()
      },
    );
  }
}

