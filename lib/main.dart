
import 'package:flutter/material.dart';
import 'mapsum.dart';


void main() => runApp(FuelCostApp());

class FuelCostApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0),
          bodyMedium: TextStyle(fontSize: 14.0),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 8,
        ),
      ),
      home: MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
