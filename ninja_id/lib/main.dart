import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: NinjaIdCard(),
  ));
}

class NinjaIdCard extends StatefulWidget {
  const NinjaIdCard({super.key});

  @override
  State<NinjaIdCard> createState() => _NinjaIdCardState();
}

class _NinjaIdCardState extends State<NinjaIdCard> {
  int ninjaLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Ninja Id Card'),
          centerTitle: true,
          backgroundColor: Colors.grey[800],
          foregroundColor: Colors.grey[200],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              ninjaLevel += 1;
            });
          },
          backgroundColor: Colors.grey[800],
          child: Icon(
            Icons.add,
            color: Colors.grey[400],
          ),
          shape: CircleBorder(),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/thumb.jpeg'),
                  radius: 40.0,
                ),
              ),
              Divider(
                height: 90.0,
                color: Colors.grey[900],
              ),
              Text(
                'NAME',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16.0,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Chun-Li',
                style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              const SizedBox(height: 30.0),
              Text(
                'CURRENT NINJA LEVEL',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16.0,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                '$ninjaLevel',
                style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              const SizedBox(height: 30.0),
              Row(
                children: [
                  Icon(Icons.mail, color: Colors.grey[400]),
                  const SizedBox(width: 8.0),
                  Text(
                    'chun.li@themetninja.com',
                    style:
                        TextStyle(color: Colors.grey[400], letterSpacing: 1.0),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
