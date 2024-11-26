abstract class UIState {}

class Idle extends UIState {}

class Loading extends UIState {}

class Error extends UIState {
  final String message;
  Error(this.message);
}

class Success extends UIState {}
