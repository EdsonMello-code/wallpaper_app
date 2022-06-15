import 'local_path_service.dart';

class LocalPathProviderServiceImpl implements LocalPathService {
  @override
  Future<String> getDownloadPath() async {
    return '/storage/emulated/0/Download/';
  }
}
