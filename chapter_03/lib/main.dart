import 'package:chapter_03/basic_screen.dart';
import 'package:chapter_03/immutable_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const StaticApp());

class StaticApp extends StatelessWidget {
  const StaticApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        appBarTheme: AppBarTheme(
          elevation: 10,
          toolbarTextStyle: const TextTheme(
            titleMedium: TextStyle(
              fontFamily: 'LeckerliOne',
              fontSize: 24,
            ),
          ).bodyText2,
          titleTextStyle: const TextTheme(
            titleMedium: TextStyle(
              fontFamily: 'LeckerliOne',
              fontSize: 24,
            ),
          ).headline6,
        ),
      ),
      home: const ImmutableWidget(),
      // home: const BasicScreen(),
    );
  }
}
