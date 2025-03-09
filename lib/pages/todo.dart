class ToDo {
  String? id;
  String todoText;
  String category;
  bool isDone;
  String Description;
  String StartDate;
  String EndDate;

  ToDo({
    required this.id,
    required this.category,
    required this.todoText,
    this.isDone = false,
    required this.Description,
    required this.StartDate,
    required this.EndDate,
  });

  static List<ToDo> todoList() {
    return [];
  }
}
