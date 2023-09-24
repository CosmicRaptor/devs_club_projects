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
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  late double text = 0;
  late var finalColour = Colors.red;
  late String finalText = "None";
  void getBMI() {
    setState(() {
      double height = double.parse(heightController.text)/100;   //Height in metres
      double weight = double.parse(weightController.text);
      text = weight/(height*height);
      text = text.roundToDouble();
      if (text <= 18.5) {
        finalColour = Colors.red;
        finalText = "Underweight";
      }
      else if (text > 18.5 && text < 25) {
        finalColour = Colors.green;
        finalText = "Healthy";
      }
      else if (text >= 25) {
        finalColour = Colors.red;
        finalText = "Overweight";
      }
      else {
        finalColour = Colors.red;
        finalText = "Error";
      }
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

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
              'Enter your weight(kg): ',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amberAccent)
                ),
              ),
              style: const TextStyle(
                color: Colors.amberAccent
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Enter your height(cm): ',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amberAccent)
                ),
              ),
              style: const TextStyle(
                  color: Colors.amberAccent
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber[600])
                  ),
                  onPressed: getBMI,
                  child: const Text('Calculate'),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Text(
                  'Result:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$text $finalText',
                  style: TextStyle(
                    color: finalColour,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  )
                  ,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
