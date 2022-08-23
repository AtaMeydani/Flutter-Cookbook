import 'package:chapter_04/profile_screen.dart';
import 'package:flutter/material.dart';
import 'deep_tree.dart';
import 'e_commerce_screen.dart';
import 'flex_screen.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green,
          textTheme: const TextTheme(headline6: TextStyle(fontSize: 24, fontFamily: 'LeckerliOne')),
          appBarTheme: const AppBarTheme(
            elevation: 10,
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontFamily: 'LeckerliOne',
            ),
            color: Colors.green,
          ),
        ),
        // home: const DeepTree(),
        // home: const ProfileScreen(),
        // home: const FlexScreen(),
        home: const ECommerceScreen(),
      ),
    );
