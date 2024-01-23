import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data);

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      print(result);
                      setState(() {
                        data = {
                          'time' : result['time'],
                          'location' : result['location'],
                          'flag' : result['flag'],
                          'isDayTime' : result['isDayTime'],
                        };
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey[300],
                        ),
                        Text(
                          'choose a location',
                          style: TextStyle(color: Colors.grey[300]),
                        )
                      ],
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                      fontSize: 66.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
