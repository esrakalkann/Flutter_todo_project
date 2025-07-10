class ToDoModel {

  
  final int id;
  final String text;
  final bool isCompleted;

  ToDoModel({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  //tamamlanıp tamamlanmama durumu
  ToDoModel toggleCompletion() {
    return ToDoModel(
      id: id,
      text: text,
      isCompleted: !isCompleted,
    );
  }

  ToDoModel copyWith({String? text, bool? isCompleted}) {
  return ToDoModel(
    id: id,
    text: text ?? this.text,
    isCompleted: isCompleted ?? this.isCompleted,
  );
}

}