import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_two/app/modules/home/home_module.dart';
import 'package:uno/uno.dart';

class AppModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: HomeModule(),
    ),
  ];

  @override
  final List<Bind<Object>> binds = [
    Bind.lazySingleton(
      (i) => Uno(
        baseURL: 'https://api.pexels.com/v1',
      ),
    ),
  ];
}
