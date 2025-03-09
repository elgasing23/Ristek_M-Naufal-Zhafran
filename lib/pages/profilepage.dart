import 'package:flutter/material.dart';
import 'package:ristek_todoapp/pages/addtask.dart';
import 'package:ristek_todoapp/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  Profilepage({super.key});

  @override
  ProfilepageState createState() => ProfilepageState();
}

class ProfilepageState extends State<Profilepage> {
  final TextEditingController nameController = TextEditingController(text: "Your Name");
  final TextEditingController majorController = TextEditingController(text: "Your Major");
  final TextEditingController hobbyController = TextEditingController(text: "Your Hobby");
  final TextEditingController dobController = TextEditingController(text: "DD-MM-YYYY");
  final TextEditingController emailController = TextEditingController(text: "email@ristek.ui.ac.id");

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
    prefs.setString('major', majorController.text);
    prefs.setString('hobby', hobbyController.text);
    prefs.setString('dob', dobController.text);
    prefs.setString('email', emailController.text);
  }

  void loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? "Your Name";
      majorController.text = prefs.getString('major') ?? "Your Major";
      hobbyController.text = prefs.getString('hobby') ?? "Your Hobby";
      dobController.text = prefs.getString('dob') ?? "DD-MM-YYYY";
      emailController.text = prefs.getString('email') ?? "email@ristek.ui.ac.id";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "", 
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey[700],
                          child: Icon(Icons.person, color: Colors.white, size: 55),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(232, 88, 24, 190),
                      size: 22,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              buildProfileField("Name", nameController),
              buildProfileField("Major", majorController),
              buildProfileField("Hobby", hobbyController, icon: Icons.favorite),
              buildProfileField("Date of Birth", dobController, icon: Icons.calendar_today),
              buildProfileField("Email", emailController, icon: Icons.email),
            ],
          ),
        ),
      ),
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
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MyWidget(),
                  ),
                  (route) => false,
                );
              },
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.person_outline,
                  color: const Color.fromARGB(232, 88, 24, 190)),
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
                builder: (context) => AddTaskPage(onTaskAdded: (ToDo) {}),
              ),
            );
          },
          backgroundColor: const Color.fromARGB(232, 88, 24, 190),
          elevation: 0,
          child: Icon(Icons.add, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildProfileField(String label, TextEditingController controller, {IconData? icon}) {
    FocusNode focusNode = FocusNode();
    bool isEditing = false;

    return StatefulBuilder(
      builder: (context, setState) {
        focusNode.addListener(() {
          setState(() {
            isEditing = focusNode.hasFocus || controller.text.isNotEmpty;
          });
        });

        return Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (value) => saveProfile(), 
                style: TextStyle(
                  color: isEditing ? Colors.white : Colors.white54, 
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  prefixIcon: icon != null ? Icon(icon, color: Colors.white60) : null,
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: const Color.fromARGB(232, 88, 24, 190), width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
