class HttpError implements Exception {
  final String message;

  const HttpError(this.message);
}
