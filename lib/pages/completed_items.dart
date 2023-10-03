import 'package:devs_club_projects/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:devs_club_projects/task_card.dart';
import 'package:devs_club_projects/database/database.dart';

class CompletedItems extends StatefulWidget {
  bool isLoaded = true;
  CompletedItems();


  @override
  State<CompletedItems> createState() => _CompletedItemsState();
}

class _CompletedItemsState extends State<CompletedItems> {
  List taskList = [];

  void getInitialData() async {
    taskList = await getEntireData(true);
    setState(() {});
  }

  void getImp() async {
    taskList = await getOnlyImportant(true);
    setState(() {});
  }

  void getNonImp() async {
    taskList = await getOnlyNonImportant(true);
    setState(() {});
  }

  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  String dropDownValue = 'Not Important';
  var values = ['Important', 'Not Important'];

  @override
  void initState() {
    widget.isLoaded = true;
    getInitialData();
    super.initState();
  }

  @override
  void dispose() {
    widget.isLoaded = false;
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context,
                builder: (_) {
                  taskNameController.clear();
                  taskDescriptionController.clear();
                  return StatefulBuilder(
                      builder: (context, setState) {
                        return SimpleDialog(
                          title: Text('New task'),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0,
                                  horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    maxLength: 50,
                                    maxLengthEnforcement: MaxLengthEnforcement
                                        .enforced,
                                    controller: taskNameController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Title'
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextField(
                                    maxLength: 300,
                                    maxLengthEnforcement: MaxLengthEnforcement
                                        .enforced,
                                    controller: taskDescriptionController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Description'
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 3.0,),
                                      DropdownButton(
                                          value: dropDownValue,
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
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            //print(taskDescriptionController.text);
                                            //print(dropDownValue);
                                            addData(Tasks(
                                                Name: taskNameController.text,
                                                Description: taskDescriptionController
                                                    .text,
                                                Tag: dropDownValue,
                                                Status: false));
                                            getInitialData();
                                            Navigator.pop(context);
                                          });
                                        }, child: Text('Submit'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: taskList.map((task) =>
                  TaskCard(
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