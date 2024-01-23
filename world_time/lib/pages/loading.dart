import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_tile.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUpWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Berlin', flag: 'Germany.png', url: 'Europe/Berlin');
    await instance.getWorldTime();
    Navigator.pushNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
          child: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 80.0,
        ),
      )),
    );
  }
}
