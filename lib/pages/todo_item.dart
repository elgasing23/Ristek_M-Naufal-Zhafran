import 'package:flutter/material.dart';
import 'package:ristek_todoapp/pages/addtask.dart';
import 'package:ristek_todoapp/pages/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  const TodoItem({Key? key, required this.todo, required void Function(String id) onTodoToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
            Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(
          onTaskAdded: (updatedTask) {
            
          },
          todo: todo,
        ),
      ),
    );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: const Color.fromARGB(232, 88, 24, 190),
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.black,
        leading: Icon(
          todo.isDone? Icons.check_box : Icons.check_box_outline_blank,
          color: const Color.fromARGB(232, 88, 24, 190),
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            decoration: todo.isDone? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.black,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}