import 'package:shared_preferences/shared_preferences.dart';
import 'package:devs_club_projects/tasks.dart';

Future<void> addData(Tasks task) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setStringList(task.Name, <String>[task.Description, task.Tag]);
}

Future<List> getEntireData() async {
  List finalData = [];
  final prefs = await SharedPreferences.getInstance();
  Set keys = prefs.getKeys();
  for(int i=0; i<keys.length; i++) {
    List<String>? the_list = prefs.getStringList(keys.elementAt(i));
    finalData.add(Tasks(Name: keys.elementAt(i), Description: the_list![0], Tag: the_list[1]));
  }
  // print(finalData[0].Description);
  return finalData;
}

Future<void> deleteData(String name) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(name);
}
