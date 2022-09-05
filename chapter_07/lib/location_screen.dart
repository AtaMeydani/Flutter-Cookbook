import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';
  LocationPermission? permission;

  @override
  void initState() {
    getPosition().then((Position myPos) {
      myPosition = 'Latitude: ${myPos.latitude} - Longitude: ${myPos.longitude}';
      setState(() {
        myPosition = myPosition;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location'),
      ),
      body: Center(
        child: Text(myPosition),
      ),
    );
  }

  Future<Position> getPosition() async {
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
