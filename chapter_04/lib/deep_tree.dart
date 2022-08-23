import 'package:flutter/material.dart';

class DeepTree extends StatelessWidget {
  const DeepTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                FlutterLogo(),
                Text('Flutter is amazing.'),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.purple,
              ),
            ),
            const Text('Its all widgets!'),
            const Text('Let\'s find out how deep the rabbit hole goes.'),
          ],
        ),
      ),
    );
  }
}
