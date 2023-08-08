import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/data/database.dart';
import 'package:notes_app/utils/dialog_box.dart';
import 'package:notes_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this is the first time ever opening the app create default data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there is already data
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCanel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      appBar: AppBar(
        backgroundColor: Colors.orange[600],
        elevation: 0,
        title: Text(
          "NOTES APP",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[700],
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoListTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (
              value,
            ) =>
                checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
