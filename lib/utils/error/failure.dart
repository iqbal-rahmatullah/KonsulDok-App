class Failure {
  final String message;
  Failure([this.message = 'An unexpected error occurred.']);
}

class NotFoundFailure extends Failure {
  NotFoundFailure([String message = 'Data not found']) : super(message);
}
