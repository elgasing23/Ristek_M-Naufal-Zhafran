import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ristek_todoapp/pages/todo.dart';

class AddTaskPage extends StatefulWidget {
  final Function(ToDo) onTaskAdded;
  final ToDo? todo;

  AddTaskPage({Key? key, required this.onTaskAdded, this.todo}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String category = "Daily Task";
  String startDate = DateFormat('MMM-dd-yyyy').format(DateTime.now());
  String endDate = DateFormat('MMM-dd-yyyy').format(DateTime.now().add(Duration(days: 1)));

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.todoText;
      category = widget.todo!.category;
    }
  }

  void _selectDate(bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          startDate = DateFormat('MMM-dd-yyyy').format(pickedDate);
        } else {
          endDate = DateFormat('MMM-dd-yyyy').format(pickedDate);
        }
      });
    }
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) return;

    final newTask = ToDo(
      id: widget.todo?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: _titleController.text,
      category: category,
    );

    widget.onTaskAdded(newTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF121212),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      widget.todo == null ? "Add Task" : "Edit Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDatePicker("Start", startDate, () => _selectDate(true)),
                      _buildDatePicker("Ends", endDate, () => _selectDate(false)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTextField("Title", "Enter task title", controller: _titleController),
                  const SizedBox(height: 20),
                  _buildCategoryButtons(),
                  const SizedBox(height: 20),
                  _buildTextField("Description", "Enter task description", maxLines: 5, controller: _descController),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveTask,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(232, 88, 24, 190)),
                      child: Text(widget.todo == null ? "Create Task" : "Save Task", style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(String label, String date, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.white, size: 18),
                const SizedBox(width: 10),
                Text(date, style: const TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Category", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => setState(() => category = "Priority Task"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: category == "Priority Task" ? const Color.fromARGB(232, 88, 24, 190) : Colors.grey[600],
                ),
                child: const Text("Priority Task", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => setState(() => category = "Daily Task"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: category == "Daily Task" ? const Color.fromARGB(232, 88, 24, 190) : Colors.grey[600],
                ),
                child: const Text("Daily Task", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
