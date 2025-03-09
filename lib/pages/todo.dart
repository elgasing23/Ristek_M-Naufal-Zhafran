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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'category': category,
      'isDone': isDone,
      'Description': Description,
      'StartDate': StartDate,
      'EndDate': EndDate,
    };
  }

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      category: json['category'],
      isDone: json['isDone'],
      Description: json['Description'],
      StartDate: json['StartDate'],
      EndDate: json['EndDate'],
    );
  }
}
