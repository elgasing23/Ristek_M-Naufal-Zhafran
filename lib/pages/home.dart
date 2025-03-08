import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.home, color: const Color.fromARGB(232, 88, 24, 190)), 
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.assignment, color: Colors.grey),
              onPressed: () {},
            ),
            SizedBox(width: 40), 
            IconButton(
              icon: Icon(Icons.priority_high, color: Colors.grey), 
              onPressed: () {},
            ),
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
          border: Border.all(color: const Color.fromARGB(232, 88, 24, 190), width: 4), 
      ),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(232, 88, 24, 190), 
        elevation: 0,
        child: Icon(Icons.add, color: Colors.black), 
  ),
),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}

