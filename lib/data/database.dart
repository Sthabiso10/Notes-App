import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  //reference the box

  final _myBox = Hive.box('mybox');

  //run method if this is first time opening the app.
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Excercise", false]
    ];
  }

  //load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
