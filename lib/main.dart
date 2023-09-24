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
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your weight: ',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amberAccent)
                ),
              ),
              style: TextStyle(
                color: Colors.amberAccent
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Enter your height: ',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amberAccent)
                ),
              ),
              style: TextStyle(
                  color: Colors.amberAccent
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber[600])
                  ),
                  onPressed: () {},
                  child: const Text('Calculate'),
              ),
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                  'Result:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
              )
            )
          ],
        ),
      ),
    );
  }
}
