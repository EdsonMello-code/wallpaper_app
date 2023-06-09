class AppFailure implements Exception {
  final String message;

  const AppFailure(
    this.message,
  );
}
