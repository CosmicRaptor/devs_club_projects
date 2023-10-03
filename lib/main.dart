import 'package:devs_club_projects/pages/all_items.dart';
import 'package:devs_club_projects/pages/completed_items.dart';
import 'package:devs_club_projects/pages/pending_items.dart';
import 'package:flutter/material.dart';
import 'database/database.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
with SingleTickerProviderStateMixin{

  List taskList = [];
  late TabController controller;
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
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('To-do list'),
          centerTitle: true,
          bottom: TabBar(
            controller: controller,
            tabs: [
              Tab(text: 'All',),
              Tab(text: 'Pending',),
              Tab(text: 'Completed',)
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            AllItems(),
            PendingItems(),
            CompletedItems()
          ],
        ),
      );
  }
}
