import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;
  
  void getData() async {
    
    String userName = await Future.delayed(Duration(seconds: 3),(){
      return 'yoshi';
    });
    
    String bio = await Future.delayed(Duration(seconds: 2),(){
      return 'vaga, musician & egg collector.';
    });
    
    print('$userName - $bio');
  }

  @override
  void initState() {
    super.initState();
    print('initState function ran.');
    getData();
    print('hey, statement.');
  }

  @override
  Widget build(BuildContext context) {
    print('build function ran.');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Choose a Location'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      body: ElevatedButton(
        onPressed: () {
          setState(() {
            counter += 1;
          });
        },
        child: Text('counter is $counter'),
      ),
    );
  }
}
