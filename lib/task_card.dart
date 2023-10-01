import 'package:devs_club_projects/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tasks.dart';

class TaskCard extends StatefulWidget {
  final Tasks task;
  final Function() delete;
  final Function() edit;
  String selectedTag = 'Not Important';


  TaskCard ({ required this.task, required this.delete, required this.edit});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Color getColor(tag){
    if (tag=="Important"){
      return Colors.red;
    }
    else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String originalTitle = widget.task.Name;
    final taskTitleEditController = TextEditingController(text: originalTitle);
    final taskDescriptionEditController = TextEditingController(text: widget.task.Description);

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: getColor(widget.task.Tag)
        ),
        borderRadius: BorderRadius.circular(20.0)
      ),
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child:
        Padding(
          padding: EdgeInsets.all(12.0),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                      widget.task.Name,
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.grey[800]
                      )
                  ),
                  SizedBox(width: 20.0,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: getColor(widget.task.Tag)
                    ),
                    child: Text(widget.task.Tag),
                  )
                ],
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
                                      DropdownButton(
                                        value: widget.selectedTag,
                                          items: ['Important', 'Not Important'].map((String value){
                                            return DropdownMenuItem(
                                              value: value,
                                              child:
                                                Text(value)
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue){
                                            setState(() {
                                              widget.selectedTag = newValue!;
                                            });
                                          }),
                                      TextButton(onPressed: () async{
                                        await deleteData(originalTitle);
                                        await addData(Tasks(Name: taskTitleEditController.text, Description: taskDescriptionEditController.text, Tag: widget.selectedTag));
                                        widget.edit();
                                        Navigator.pop(context);
                                      }, child: Text('Submit'))
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
                    onPressed: (){
                      showDialog(context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Please confirm'),
                            content: Text('Are you sure you want to delete this task?'),
                            actions: [
                              // Yes button
                              TextButton(onPressed: (){widget.delete(); Navigator.pop(context);},
                                  child: Text('Yes')),
                              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('No'))
                            ],
                          ));
                    },
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