import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_two/app/modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: HomeModule(),
    ),
  ];
}
