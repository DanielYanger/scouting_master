import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'formCreator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Map<int, Color> color = {
    50: Color.fromRGBO(6, 240, 0, .1),
    100: Color.fromRGBO(6, 240, 0, .2),
    200: Color.fromRGBO(6, 240, 0, .3),
    300: Color.fromRGBO(6, 240, 0, .4),
    400: Color.fromRGBO(6, 240, 0, .5),
    500: Color.fromRGBO(6, 240, 0, .6),
    600: Color.fromRGBO(6, 240, 0, .7),
    700: Color.fromRGBO(6, 240, 0, .8),
    800: Color.fromRGBO(6, 240, 0, .9),
    900: Color.fromRGBO(6, 240, 0, 1),
  };

  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF03CC00, color);
    return MaterialApp(
      title: 'Master Scouting App',
      theme: ThemeData(
        primarySwatch: colorCustom,
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
