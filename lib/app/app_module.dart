import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_two/app/modules/home/home_module.dart';
import 'package:uno/uno.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
  }

  @override
  void binds(Injector i) {
    i.addLazySingleton(
      () => Uno(),
    );
  }
}
