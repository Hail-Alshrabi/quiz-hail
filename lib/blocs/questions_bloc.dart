import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/question.dart';
import 'package:demo/models/state.dart';
import 'package:demo/models/state_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuestionsBloc {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _controller = StreamController<StateModel<List<Question>>>.broadcast();

  Stream<StateModel<List<Question>>> get questions => _controller.stream;

  Future<void> getQuestions() async {
    _controller.add(StateModel(state: BlocState.loading));

    try {
      CollectionReference questionsRef =
          FirebaseFirestore.instance.collection('questions');
      QuerySnapshot questionsSnapshot = await questionsRef.get();
      List<Question> res = [];

      for (QueryDocumentSnapshot questionDoc in questionsSnapshot.docs) {
        res.add(Question.fromMap(questionDoc.data() as Map<String, dynamic>));
      }

      _controller.add(StateModel(state: BlocState.success, data: res));
    } catch (_) {
      _controller.add(StateModel(state: BlocState.fails));
    }
  }

  Future<void> uploadScore(int score) async {
    _controller.add(StateModel(state: BlocState.loading));

    try {
      User? user = auth.currentUser;
      if (user == null) return;

      String userId = user.uid;
      String userName = user.displayName ?? '';

      DocumentReference docRef =
          firestore.collection('leaderboard').doc(userId);
      bool docExists = await docRef.get().then((doc) => doc.exists);
      if (docExists) {
        await docRef.update({'userName': userName, 'score': score});
      } else {
        await docRef.set({'userName': userName, 'score': score});
      }
      _controller.add(StateModel(state: BlocState.success));
    } catch (_) {
      _controller.add(StateModel(state: BlocState.fails));
    }
  }

  void dispose() {
    _controller.close();
  }
}
