import 'package:demo/blocs/leaderboard_bloc.dart';
import 'package:demo/models/score.dart';
import 'package:demo/models/state_model.dart';
import 'package:flutter/material.dart';
import 'package:demo/models/state.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  final _bloc = LeaderboardBloc();
  @override
  void initState() {
    super.initState();

    _bloc.populateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<StateModel<LeaderboradModel>>(
              stream: _bloc.data,
              builder: (context, snapshot) {
                if (snapshot.data?.state == BlocState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(children: [
                  const Center(
                      child: Text(
                    "Score:",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  currentUserSection(snapshot.data?.data?.currentScore ?? 0),
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(
                      child: Text(
                    "Leaderboard:",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.data?.leaderboard.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        Score score = snapshot.data!.data!.leaderboard[index];
                        return Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            title: Text(
                              score.userName,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              "Score: ${score.score}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]);
              }),
        ),
      ),
    );
  }

  Widget currentUserSection(int score) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Score',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                score.toString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
