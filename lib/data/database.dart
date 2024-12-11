import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List toDoList = [];

// refrence the box
  final _myBox = Hive.box("mybox");

//run this method if the app is opened for the first time
  void createInitialData() {
    toDoList = [
      ["make tutorial", false],
      ["Do Exercise", false]
    ];
  }


  // load the data from database

  void loadData(){
    toDoList = _myBox.get("TODOLIST");

  }


  //update teh database
  void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);
  }

}
