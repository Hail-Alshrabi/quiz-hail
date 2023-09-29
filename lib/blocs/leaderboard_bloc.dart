import 'dart:async';

import 'package:demo/models/score.dart';
import 'package:demo/models/state.dart';
import 'package:demo/models/state_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardBloc {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _controller =
      StreamController<StateModel<LeaderboradModel>>.broadcast();

  Stream<StateModel<LeaderboradModel>> get data => _controller.stream;

  populateData() async {
    _controller.add(StateModel(state: BlocState.loading));

    try {
      List<Score> leaderboard = await _getTopScores();
      int? currentScore = await _getCurrentUserScore();

      _controller.add(StateModel(
          state: BlocState.success,
          data: LeaderboradModel(
              leaderboard: leaderboard, currentScore: currentScore ?? 0)));
    } catch (e) {
      _controller.add(StateModel(state: BlocState.fails));
    }
  }

  Future<List<Score>> _getTopScores() async {
    QuerySnapshot snapshot = await firestore
        .collection('leaderboard')
        .orderBy('score', descending: true)
        .limit(5)
        .get();
    List<Score> scores = snapshot.docs
        .map((doc) => Score.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return scores;
  }

  Future<int?> _getCurrentUserScore() async {
    User? user = auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot snapshot =
          await firestore.collection('leaderboard').doc(userId).get();
      if (snapshot.exists) {
        int score = (snapshot.data() as Map<String, dynamic>)['score'];
        return score;
      } else {
        return 0;
      }
    }

    return null;
  }
}

class LeaderboradModel {
  List<Score> leaderboard;
  int currentScore;

  LeaderboradModel({
    required this.leaderboard,
    required this.currentScore,
  });
}
