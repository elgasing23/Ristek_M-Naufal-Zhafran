class ToDo {
  String? id;
  String todoText;
  String category;
  bool isDone;

  ToDo({required this.id, required this.category, required this.todoText, this.isDone = false});

  static List<ToDo> todoList() {
    return [

    ];
  }
}
