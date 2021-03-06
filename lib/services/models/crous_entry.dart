class CrousEntry {
  final int id;
  final String title;
  final String body;

  CrousEntry({this.id, this.title, this.body});

  factory CrousEntry.fromJson(Map<String, dynamic> json) {
    return CrousEntry(id: json['id'], title: json['entry_title'], body: json['entry_text']);
  }
}
