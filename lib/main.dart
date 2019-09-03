import 'package:weather_app/screens/climate_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "climate App",
      debugShowCheckedModeBanner: false,
      home: ClimateScreen(),
    );
  }
}
