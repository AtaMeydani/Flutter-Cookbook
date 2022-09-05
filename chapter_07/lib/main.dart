import 'dart:async';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import 'location_screen.dart';
import 'navigation_dialog.dart';
import 'navigation_first.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: const NavigationDialog(),
      // home: const NavigationFirst(),
      // home: const LocationScreen(),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({Key? key}) : super(key: key);

  @override
  State createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String? result;
  Completer<int>? completer;

  Future<int>? getNumber() {
    completer = Completer();
    calculate();
    return completer?.future;
  }

  calculate() async {
    await Future.delayed(const Duration(seconds: 5));
    completer?.complete(42);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: () {
                /* count(); */

                /* returnFG();*/

                /*returnError().then((value) {
                  setState(() {
                    result = 'Success';
                  });
                  return Future.error('Error');
                }, onError: (onError) {
                  setState(() {
                    result = 'Error from future: $onError';
                  });
                }).catchError((onError) {
                  setState(() {
                    result = 'Error from then: $onError';
                  });
                }).whenComplete(() => dev.log('Complete'));*/

                getData().then((value) {
                  setState(() {
                    result = value.body.toString().substring(0, 450);
                  });
                }).catchError((_) {
                  setState(() {
                    result = 'an error occurred';
                  });
                });
              },
            ),
            const Spacer(),
            Text(result.toString()),
            const Spacer(),
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  void count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  void returnFG() {
    FutureGroup<int> futureGroup = FutureGroup<int>();
    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    futureGroup.close();
    futureGroup.future.then((List<int> value) {
      int total = 0;
      for (var element in value) {
        total += element;
      }
      setState(() {
        result = total.toString();
      });
    });
  }

  Future returnError() {
    // return Future.value('ok');
    return Future.error('Something terrible happened!');
  }

  Future<http.Response> getData() async {
    const String authority = 'www.googleapis.com';
    const String path = '/books/v1/volumes/junbDwAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }
}
