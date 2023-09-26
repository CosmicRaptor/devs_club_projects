import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tasks.dart';

class TaskCard extends StatelessWidget {
  final Tasks task;
  final Function() delete;

  TaskCard ({ required this.task, required this.delete });





  @override
  Widget build(BuildContext context) {
    final taskTitleEditController = TextEditingController(text: task.Name);
    final taskDescriptionEditController = TextEditingController(text: task.Description);
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
                                    TextButton(onPressed: (){}, child: Text('Submit'))
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
                      onPressed: delete,
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
