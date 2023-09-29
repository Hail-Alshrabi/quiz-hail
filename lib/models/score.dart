import 'dart:convert';

class Score {
  final String userId;
  final String userName;
  final int score;

  Score({required this.userId, required this.userName, required this.score});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'score': score,
    };
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      score: map['score']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Score.fromJson(String source) => Score.fromMap(json.decode(source));
}
