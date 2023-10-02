import 'package:devs_club_projects/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tasks.dart';

class TaskCard extends StatefulWidget {
  final Tasks task;
  final Function() delete;
  final Function() edit;
  bool? isComplete = false;
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
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Checkbox(value: widget.task.Status, onChanged: (bool? value){
                    widget.isComplete = value;
                    deleteData(widget.task.Name);
                    addData(Tasks(Name: widget.task.Name, Description: widget.task.Description, Tag: widget.task.Tag, Status: value ?? true));
                    widget.edit();
                  }),
                  SizedBox(
                    width: 170.0,
                    child: Text(
                        widget.task.Name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.grey[800]
                        )
                    ),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 8.0, 0.0),
                child: Text(
                    widget.task.Description,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[600]
                    )
                ),
              ),
              SizedBox(height: 8.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){
                    showDialog(context: context,
                        builder: (_) => AlertDialog(
                          title: Text(widget.task.Name),
                          content: Text(widget.task.Description),
                          actions: [
                            TextButton(onPressed: (){Navigator.pop(context);}, child: Text('OK'))
                          ],
                        ));
                  },
                  icon: Icon(Icons.info, color: Colors.blueAccent,),),
                  IconButton(
                      onPressed: () {
                        showDialog(context: context,
                            builder: (_) => StatefulBuilder(
                              builder: (context, setState) {
                                return SimpleDialog(
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextButton(onPressed: () async{
                                                await deleteData(originalTitle);
                                                await addData(Tasks(Name: taskTitleEditController.text, Description: taskDescriptionEditController.text, Tag: widget.selectedTag, Status: widget.isComplete ?? false));
                                                widget.edit();
                                                Navigator.pop(context);
                                              }, child: Text('Submit')),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                            )
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blueAccent,),
                  ),
                  IconButton(
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
                    icon: Icon(Icons.delete, color: Colors.blueAccent,),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}