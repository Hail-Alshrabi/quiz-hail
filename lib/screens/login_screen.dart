import 'package:demo/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:demo/models/state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _bloc.loginState.listen((event) {
      if (event == BlocState.success) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<BlocState>(
            stream: _bloc.loginState,
            initialData: BlocState.init,
            builder: (context, snapshot) {
              if (snapshot.data == BlocState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SizedBox(
                height: 40,
                child: SignInButton(
                  Buttons.Google,
                  onPressed: _bloc.signInWithGoogle,
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
