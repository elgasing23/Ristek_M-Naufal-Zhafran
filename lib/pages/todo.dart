class ToDo {
  String? id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: "tes 1", isDone: true),
      ToDo(id: '02', todoText: "tes 2"),
      ToDo(id: '03', todoText: "tes 3"),
      ToDo(id: '04', todoText: "tes 4"),
      ToDo(id: '05', todoText: "tes 5"),
      ToDo(id: '06', todoText: "tes 6"),
    ];
  }
}
