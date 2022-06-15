import 'package:permission_handler/permission_handler.dart';
import 'package:test_two/app/core/services/permission/permission_service.dart';

class PermissionServiceImpl implements PermissionService {
  @override
  Future<bool> getStoragePermission() {
    final permissionStorageStatus = Permission.manageExternalStorage.request();

    return permissionStorageStatus.isGranted;
  }
}
