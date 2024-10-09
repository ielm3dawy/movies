
sealed class SearchStates {}

class InitialSearchState extends SearchStates {}

class ErrorSearchState extends SearchStates {
  final String error;

  ErrorSearchState(this.error);
}

class SuccessSearchState extends SearchStates {}
