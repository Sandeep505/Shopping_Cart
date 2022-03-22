import 'package:flutter/material.dart';


import 'constants/constants.dart';
import 'screen/home/home_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organic Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: white
      ),
      home: HomeScreen(),
    );
  }
}

