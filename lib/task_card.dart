import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tasks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database.dart';

class TaskCard extends StatefulWidget {
  final Tasks task;
  final Function() delete;

  TaskCard ({ required this.task, required this.delete });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {



  @override
  Widget build(BuildContext context) {
    final taskTitleEditController = TextEditingController(text: widget.task.Name);
    final taskDescriptionEditController = TextEditingController(text: widget.task.Description);
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
                  widget.task.Name,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[800]
                  )
              ),
              SizedBox(height: 6.0,),
              Text(
                  widget.task.Description,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600]
                  )
              ),
              SizedBox(height: 8.0,),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      showDialog(context: context,
                          builder: (_) => SimpleDialog(
                            title: Text('Edit task'),
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Title:'),
                                    SizedBox(height: 6.0,),
                                    TextField(
                                      maxLength: 50,
                                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                      controller: taskTitleEditController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder()
                                      ),
                                    ),
                                    SizedBox(height: 10.0,),
                                    Text('Description:'),
                                    SizedBox(height:6.0),
                                    TextField(
                                      maxLength: 300,
                                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                      controller: taskDescriptionEditController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder()
                                      ),
                                    ),
                                    SizedBox(height: 6.0,),
                                    TextButton(onPressed: () {updateData(taskTitleEditController.text);}, child: Text('Submit'))
                                  ],
                                ),
                              )
                            ],
                          )
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit')
                  ),
                  SizedBox(width: 10.0,),
                  TextButton.icon(
                      onPressed: () {widget.delete; deleteData(widget.task.Name);},
                      icon: Icon(Icons.delete),
                      label: Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
