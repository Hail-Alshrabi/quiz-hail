import 'package:demo/models/choice.dart';
import 'package:demo/models/state_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/question.dart';
import 'package:demo/blocs/questions_bloc.dart';
import 'package:demo/models/state.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<Question> questions = [];
  List<Choice> answers = [];

  final _bloc = QuestionsBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getQuestions();

    _bloc.questions.listen((event) {
      if (event.state == BlocState.success) {
        if (event.data != null) {
          questions = event.data ?? [];
          for (var _ in questions) {
            answers.add(Choice(text: ""));
          }
        } else {
          Navigator.pushNamed(context, "/leaderboard");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<StateModel>(
              stream: _bloc.questions,
              initialData: StateModel(state: BlocState.loading),
              builder: (context, snapshot) {
                if (snapshot.data?.state == BlocState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(children: [
                  const Center(child: Text("Quiz")),
                  Expanded(
                      child: ListView(
                    children: [
                      Column(
                        children: List.generate(
                            questions.length,
                            (index) =>
                                _questionWidget(questions[index], index)),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: onSubmit,
                            child: const Center(
                              child: Text("Submit"),
                            )),
                      )
                    ],
                  ))
                ]);
              }),
        ),
      ),
    );
  }

  Widget _questionWidget(Question item, int index) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.text,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: List<Widget>.generate(
              item.choices.length,
              (i) => RadioListTile(
                title: Text(item.choices[i].text),
                value: item.choices[i],
                groupValue: answers[index],
                onChanged: (_) => setState(() {
                  answers[index] = item.choices[i];
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSubmit() async {
    if (answers
        .where(
          (element) => element.text.isEmpty,
        )
        .isNotEmpty) return;
    int score = answers
        .where(
          (element) => element.isTrue ?? false,
        )
        .length;
    _bloc.uploadScore(score);
  }
}
