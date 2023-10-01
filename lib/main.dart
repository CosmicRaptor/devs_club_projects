import 'package:devs_club_projects/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'task_card.dart';
import 'database/database.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List taskList = [];
  void getInitialData() async{
    taskList = await getEntireData();
    setState(() {

    });
  }

  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  String dropDownValue = 'Not Important';
  var values = ['Important', 'Not Important'];

  @override
  void initState() {
    getInitialData();
    super.initState();
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
                          DropdownButton(
                            value: dropDownValue,
                            icon: Icon(Icons.arrow_downward),
                            items: values.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValue = newValue!;
                              });
                            }
                            ),
                          TextButton(
                            onPressed: (){
                              setState(() {
                                //print(taskDescriptionController.text);
                                //print(dropDownValue);
                                addData(Tasks(Name: taskNameController.text, Description: taskDescriptionController.text, Tag: dropDownValue));
                                getInitialData();
                                Navigator.pop(context);
                              });

                            }, child: Text('Submit'),
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
                    deleteData(task.Name);
                  });
                },
                edit: () {
                  setState(() {
                    getInitialData();
                  });
                },
              )).toList()
          ),
        )
    );
  }
}