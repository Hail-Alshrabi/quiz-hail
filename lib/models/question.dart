import 'dart:convert';

import 'package:demo/models/choice.dart';

class Question {
  String text;
  List<Choice> choices;

  Question({
    required this.text,
    required this.choices,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'choices': choices.map((x) => x.toMap()).toList(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['text'] ?? '',
      choices: List<Choice>.from(map['choices']?.map((x) => Choice.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
  factory Question.fromJson(String source) =>
   Question.fromMap(json.decode(source));
}


