import 'package:flutter/material.dart';
import 'tasks.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List taskList = [
    Tasks(Name: 'Test task 1', Description: 'This is a test task'),
    Tasks(Name: 'Test task 2', Description: 'This is a test task'),
    Tasks(Name: 'Test task 3', Description: 'This is a test task'),
    Tasks(Name: 'Test task 4', Description: 'This is a test task'),
    Tasks(Name: 'Test task 5', Description: 'This is a test task'),
    Tasks(Name: 'Test task 6', Description: 'This is a test task'),
    Tasks(Name: 'Test task 7', Description: 'This is a test task'),
    Tasks(Name: 'Test task 8', Description: 'This is a test task'),
    Tasks(Name: 'Test task 9', Description: 'This is a test task'),
    Tasks(Name: 'Test task 10', Description: 'This is a test task'),
    Tasks(Name: 'Test task 11', Description: 'This is a test task'),
    Tasks(Name: 'Test task 12', Description: 'This is a test task'),
  ];

  Widget taskTemplate(task) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child:
        Padding(
          padding: EdgeInsets.all(12.0),
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.Name,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[800]
                  )
                ),
                SizedBox(height: 6.0,),
                Text(
                  task.Description,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600]
                  )
                )
              ],
            ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('To-do list'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: taskList.map((task) => taskTemplate(task)).toList()
        ),
      )
    );
  }
}
