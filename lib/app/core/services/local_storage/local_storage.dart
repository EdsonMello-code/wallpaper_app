import 'package:test_two/app/core/utils/unit.dart';

abstract interface class LocalStorage {
  Future<dynamic> get(String key);

  Future<Unit> put(String key, dynamic value);
}
