class ToDoModel {

  
  final String id;
  final String text;
  final bool isCompleted;
  final String? description;   
  final DateTime? dateTime;

  

  ToDoModel({
    required this.id,
    required this.text,
    this.description,
    this.dateTime,

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
    description: description,
    dateTime: dateTime,
  );
}

}