
sealed class MainLayoutState {}

class InitializeMainLayoutState extends MainLayoutState {}

class SuccessMainLayoutState extends MainLayoutState {}

class ErrorMainLayoutState extends MainLayoutState {
  final String error;

  ErrorMainLayoutState(this.error);
}
