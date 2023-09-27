import 'package:hive_flutter/hive_flutter.dart';

String getData([key]) {
  initDB();
  var box = Hive.box('taskDB');
  print('getData: $key');
  try {
    var a = box.get(key);
    closeDB();
    return a;
  }
  catch (e) {
    closeDB();
    return e.toString();
  }
}
void updateData(key) {}
void addData(key, value) {

}
void deleteData(key) {print('deleteData: $key');}

void initDB() async {
  await Hive.initFlutter();
  await Hive.openBox('taskDB');
}

void closeDB() async {
  Hive.close();
}