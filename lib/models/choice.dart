import 'dart:convert';

class Choice {
  String text;
  bool? isTrue;

  Choice({
    required this.text,
    this.isTrue,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isTrue': isTrue,
    };
  }

  factory Choice.fromMap(Map<String, dynamic> map) {
    return Choice(
      text: map['text'] ?? '',
      isTrue: map['isTrue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Choice.fromJson(String source) => Choice.fromMap(json.decode(source));
}



