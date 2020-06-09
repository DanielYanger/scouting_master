import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'formCreator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Scouting App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            gapPadding: 10,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FormCreatorPage(),
      },
    );
  }
}
