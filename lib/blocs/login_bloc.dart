import 'dart:async';

import 'package:demo/models/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBloc {
  final _controller = StreamController<BlocState>.broadcast();

  Stream<BlocState> get loginState => _controller.stream;

  Future<void> signInWithGoogle() async {
    try {
      _controller.add(BlocState.loading);

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      _controller.add(BlocState.success);
    } catch (e) {
      _controller.add(BlocState.fails);
    }
  }

  void dispose() {
    _controller.close();
  }
}
