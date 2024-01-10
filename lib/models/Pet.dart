class Pet {
  int petted;
  DateTime lastTimePetted;
  String petFile;
  String petName;
  int petExp;
  int petLevel;

  Pet({
    required this.petName,
    required this.petLevel,
    required this.petExp,
    required this.petted,
    required this.lastTimePetted,
    required this.petFile,
  });

  Map<String, dynamic> toJson() {
    return {
      'petName': petName,
      'petLevel': petLevel,
      'petExp': petExp,
      'petted': petted,
      'lastTimePetted': lastTimePetted.toIso8601String(),
      'petFile': petFile,
    };
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      petName: json['petName'] as String,
      petExp: json['petExp'] as int,
      petLevel: json['petLevel'] as int,
      petted: json['petted'] as int,
      lastTimePetted: DateTime.parse(json['lastTimePetted'] as String),
      petFile: json['petFile'] as String,
    );
  }
}
