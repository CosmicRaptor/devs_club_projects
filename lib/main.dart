import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tasks.dart';
import 'task_card.dart';

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
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  void dispose() {
    taskDescriptionController.dispose();
    taskNameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('To-do list'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context,
              builder: (_) => SimpleDialog(
                title: Text('New task'),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          maxLength: 50,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          controller: taskNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Title'
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        TextField(
                          maxLength: 300,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          controller: taskDescriptionController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Description'
                          ),
                        ),
                        TextButton(
                            onPressed: (){}, child: Text('Submit'),
                            )
                      ],
                    ),
                  )
                ],
              ));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: taskList.map((task) => TaskCard(
              task: task,
              delete: () {
                setState(() {
                  taskList.remove(task);
                });
              },
          )).toList()
        ),
      )
    );
  }
}
