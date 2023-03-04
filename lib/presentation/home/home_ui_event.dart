abstract class HomeUiEvent<T> {
  factory HomeUiEvent.showSnackBar(String message) {
    return ShowSnackBar(message);
  }
}

class ShowSnackBar<T> implements HomeUiEvent<T> {
  final String message;

  ShowSnackBar(this.message);
}
