class Todo {
  final int id;
  final String text;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  //tamamlanıp tamamlanmama durumu
  Todo toggleCompletion() {
    return Todo(
      id: id,
      text: text,
      isCompleted: !isCompleted,
    );
  }
}