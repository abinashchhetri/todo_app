import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    //if theis is the 1st time ever opening the app set the sefult value

    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //ther already exist data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // list to store to do tasks

  // method to change the Checkbox
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // this will cancel task and clear the task that had been enterd
  void cancelMethod() {
    setState(() {
      _controller.clear();
    });

    Navigator.of(context).pop();
  }

  // this method will add new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // this method will open a dialog box to  add new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onCancel: cancelMethod,
            onSave: saveNewTask,
          );
        });
  }

  //delete Task

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "TO DO",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),

      // this part will retun the to do tasks
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (contex, index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFuntion: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
