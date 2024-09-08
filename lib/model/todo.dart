class ToDo {
  int? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: 0, todoText: 'Morning Excercise', isDone: true ),
    ];
  }
}