import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ristek_todoapp/pages/profilepage.dart';
import 'package:ristek_todoapp/pages/todo.dart';
import 'package:ristek_todoapp/pages/todo_item.dart';
import 'package:ristek_todoapp/pages/addtask.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class MyWidget extends StatefulWidget {
  MyWidget({super.key});

  @override
  MyWidgetState createState() => MyWidgetState();
  
}

class MyWidgetState extends State<MyWidget> {
  List<ToDo> todosList = [];

  @override
  void initState() {
    super.initState();
    loadTasks(); 
  }
  
  void saveTasks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> taskList =
      todosList.map((task) => jsonEncode(task.toJson())).toList();
  prefs.setStringList('tasks', taskList);
 }

 void loadTasks() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? taskList = prefs.getStringList('tasks');

  if (taskList != null) {
    setState(() {
      todosList = taskList.map((task) => ToDo.fromJson(jsonDecode(task))).toList();
    });
  }
}

  void addTask(ToDo newTask) {
    setState(() {
      todosList.add(newTask);
    });
    saveTasks();
  }

  void editTask(ToDo task) async{
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AddTaskPage(
              onTaskAdded: (updatedTask) {
                setState(() {
              todosList.removeWhere((t) => t.id == task.id);
              todosList.add(updatedTask);
              });
              saveTasks();
              },
              todo: task,
            ),
      ),
    );
  }

  void deleteTask(String id) {
    setState(() {
      todosList.removeWhere((task) => task.id == id);
    });
    saveTasks();
  }

  void toggleTaskCompletion(String id) {
    setState(() {
      int index = todosList.indexWhere((task) => task.id == id);
      if (index != -1) {
        todosList[index].isDone = !todosList[index].isDone;
      }
    });
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    String tanggal = DateFormat('EEEE, MMM d yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF121212),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: const Color.fromARGB(232, 88, 24, 190),
              ),
              onPressed: () {},
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.person_outline, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profilepage()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          border: Border.all(
            color: const Color.fromARGB(232, 88, 24, 190),
            width: 4,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskPage(onTaskAdded: addTask),
              ),
            );
          },
          backgroundColor: const Color.fromARGB(232, 88, 24, 190),
          elevation: 0,
          child: Icon(Icons.add, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          tanggal,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 4),
              child: Text(
                "Welcome User",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Have a nice day ! ",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 20),
              child: Text(
                "Daily Task",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: todosList.isEmpty
                  ? Center(
                      child: Text(
                        "No tasks available",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    )
                  : ListView(
                      children: [
                        for (ToDo todo in todosList)
                          GestureDetector(
                            onTap: () => editTask(todo),
                            child: TodoItem(
                              todo: todo,
                              onTodoToggle: toggleTaskCompletion,
                              onDelete: deleteTask,
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

