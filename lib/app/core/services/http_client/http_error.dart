import 'package:test_two/app/core/app_failure/app_failure.dart';

class HttpError implements AppFailure {
  @override
  final String message;

  const HttpError(this.message);
}
