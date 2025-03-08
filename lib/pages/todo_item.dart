import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
            onTap: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(color: const Color.fromARGB(232, 88, 24, 190,), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tileColor: Colors.black,
            leading: Icon(Icons.check_box, color: const Color.fromARGB(232, 88, 24, 190,),
            ),
            title: Text("Testing 1", style: TextStyle(
                fontSize: 16, 
                color: Colors.white, 
                decoration: TextDecoration.lineThrough,
                ), 
            ),
            trailing: Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(vertical: 12),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5)
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