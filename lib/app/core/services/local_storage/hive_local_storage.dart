import 'package:hive/hive.dart';
import 'package:test_two/app/core/services/local_storage/local_storage.dart';
import 'package:test_two/app/core/services/local_storage/local_storage_failure.dart';
import 'package:test_two/app/core/utils/unit.dart';

class HiveLocalStorage implements LocalStorage {
  final String databaseName;

  const HiveLocalStorage(this.databaseName);

  @override
  Future<dynamic> get(String key) async {
    try {
      final box = await Hive.openBox(databaseName);
      final response = box.get(key);
      await box.close();
      return response;
    } on HiveError catch (error) {
      throw LocalStorageFailure(error.message);
    }
  }

  @override
  Future<Unit> put(String key, dynamic value) async {
    try {
      final box = await Hive.openBox(databaseName);

      await box.put(key, value);
      await box.close();

      return unit;
    } on HiveError catch (error) {
      throw LocalStorageFailure(error.message);
    }
  }
}
