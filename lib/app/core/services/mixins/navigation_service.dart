import 'package:flutter_modular/flutter_modular.dart';

mixin NavigationMixin {
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Modular.to.pushNamed(
      routeName,
      arguments: arguments,
    );
  }
}
