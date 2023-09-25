import 'package:flutter/material.dart';
import 'tasks.dart';

class TaskCard extends StatelessWidget {
  final Tasks task;

  TaskCard ({ required this.task });

  @override
  Widget build(BuildContext context) {
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
}
