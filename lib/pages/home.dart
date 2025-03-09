import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ristek_todoapp/pages/todo.dart';
import 'package:ristek_todoapp/pages/todo_item.dart';
import 'package:ristek_todoapp/pages/addtask.dart';

class MyWidget extends StatefulWidget {
  MyWidget({super.key});

  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  List<ToDo> todosList = []; 

 
  void addTask(ToDo newTask) {
    setState(() {
      todosList.add(newTask);
    });
  }

  void editTask(ToDo task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(
          onTaskAdded: (updatedTask) {
            setState(() {
              int index = todosList.indexWhere((t) => t.id == task.id);
              todosList[index] = updatedTask;
            });
          },
          todo: task,
        ),
      ),
    );
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
              onPressed: () {},
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
            Expanded(
              child: ListView(
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

                  for (ToDo todo in todosList)
                    GestureDetector(
                      onTap: () => editTask(todo),
                      child: TodoItem(todo: todo, onTodoToggle: (String id) {  },),
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