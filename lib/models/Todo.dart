class Todo {
  String title;
  String description;
  DateTime resetDate;
  List<String> playlist;
  bool isCompleted;

  Todo({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.resetDate,
    required this.playlist,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'resetDate': resetDate.toIso8601String(),
      'playlist': playlist,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] as String,
      description: json['description'] as String,
      resetDate: DateTime.parse(json['resetDate'] as String),
      playlist: (json['playlist'] as List).cast<String>(),
      isCompleted: json['isCompleted'] as bool, 
    );
  }

  void setNewTitle(String newTitle){
    title = newTitle;
  }

  void setNewDescription(String newDescription){
    description = newDescription;
  }

  void setIsCompleted(bool newIsCompletedValue){
    isCompleted = newIsCompletedValue;
  }

  void reorderPlaylist(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      final item = playlist.removeAt(oldIndex);
      playlist.insert(newIndex, item);
    } else {
      final item = playlist.removeAt(oldIndex);
      playlist.insert(newIndex, item);
    }
  }

  void saveNewTodo(Todo newTodo) {
    title = newTodo.title;
    description = newTodo.description;
    resetDate = newTodo.resetDate;
    playlist = List.from(newTodo.playlist);
    isCompleted = newTodo.isCompleted;
  }

  Todo clone() {
    return Todo(
      title: title,
      description: description,
      resetDate: resetDate,
      playlist: playlist,
      isCompleted: isCompleted,
    );
  }
}

