class Habit {
  String title;
  String description;
  DateTime resetDate;
  List<Habit> subhabits;
  List<String> playlist;
  bool isCompleted;

  Habit({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.resetDate,
    required this.subhabits,
    required this.playlist,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'resetDate': resetDate.toIso8601String(),
      'playlist': playlist,
      'isCompleted': isCompleted,
      'subhabits': subhabits
          .map((subhabit) => subhabit.toJson())
          .toList(), // Serialize sub-habits
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      title: json['title'] as String,
      description: json['description'] as String,
      resetDate: DateTime.parse(json['resetDate'] as String),
      playlist: (json['playlist'] as List).cast<String>(),
      isCompleted: json['isCompleted'] as bool,
      subhabits: (json['subhabits'] != null)
          ? (json['subhabits'] as List)
              .map((subhabitJson) =>
                  Habit.fromJson(subhabitJson as Map<String, dynamic>))
              .toList()
          : [], // Handle empty subhabits
    );
  }

  void setNewTitle(String newTitle) {
    title = newTitle;
  }

  void removeSubhabit(Habit subhabit) {
    subhabits.remove(subhabit);
  }

  void setNewDescription(String newDescription) {
    description = newDescription;
  }

  void setIsCompleted(bool newIsCompletedValue) {
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

  void saveNewHabit(Habit newHabit) {
    title = newHabit.title;
    description = newHabit.description;
    resetDate = newHabit.resetDate;
    playlist = List.from(newHabit.playlist);
    isCompleted = newHabit.isCompleted;

    subhabits.clear();
    for (final subhabit in newHabit.subhabits) {
      subhabits.add(
        Habit(
          title: subhabit.title,
          description: subhabit.description,
          resetDate: subhabit.resetDate,
          playlist: List.from(subhabit.playlist),
          isCompleted: subhabit.isCompleted,
          subhabits: [],
        ),
      );
    }
  }

  void resetIfNecessary() {
    final now = DateTime.now();
    final difference = now.difference(resetDate);

    if (difference.inHours >= 12) {
      // Si han pasado 12 horas o más, resetea el isCompleted
      isCompleted = false;

      // También, resetea los subhabits si los tienes
      for (var subhabit in subhabits) {
        subhabit.resetIfNecessary();
      }
    }
  }

  Habit clone() {
    return Habit(
      title: title,
      description: description,
      resetDate: resetDate,
      subhabits: subhabits,
      playlist: playlist,
      isCompleted: isCompleted,
    );
  }
}
