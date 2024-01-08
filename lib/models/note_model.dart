class Note {
  final int? id;
  final String title;
  final String descripsi;
  final DateTime time;

  Note(
      {required this.id,
      required this.title,
      required this.descripsi,
      required this.time});

//ini hasil generate code di atas menjadi bentuk JSON serialization
  Note copyWith({
    int? id,
    String? title,
    String? descripsi,
    DateTime? time,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      descripsi: descripsi ?? this.descripsi,
      time: time ?? this.time,
    );
  }

  factory Note.fromMap(Map<String, dynamic> map) => Note(
        id: map["id"]?.toInt(),
        title: map["title"] ?? '',
        descripsi: map["descripsi"] ?? '',
        time: DateTime.fromMillisecondsSinceEpoch(int.parse(map["time"])),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "descripsi": descripsi,
        "time": time.millisecondsSinceEpoch,
      };
}
