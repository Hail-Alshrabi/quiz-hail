import 'package:demo/models/state.dart';

class StateModel<T> {
  BlocState state;
  T? data;

  StateModel({
    required this.state,
    this.data,
  });
}
