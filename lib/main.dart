import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('BMI Calculator'),
        titleSpacing: 2.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your weight: ',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amberAccent)
                ),
              ),
              style: TextStyle(
                color: Colors.amberAccent
              ),
            )
          ],
        ),
      ),
    );
  }
}
