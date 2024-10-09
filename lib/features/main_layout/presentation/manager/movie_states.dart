sealed class MovieStates{}

class InitialMovieStates extends MovieStates {}
class ErrorMovieStates extends MovieStates {
  final String error;

  ErrorMovieStates(this.error);
}
class SuccessMovieStates extends MovieStates {}