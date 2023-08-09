abstract interface class Either<L, R> {
  void fold({
    void Function(R value)? right,
    void Function(L value)? left,
  });
}

class Right<L, R> implements Either<L, R> {
  final R _value;

  const Right(this._value);

  @override
  void fold({
    void Function(R value)? right,
    void Function(L value)? left,
  }) {
    right?.call(_value);
  }
}

class Left<L, R> implements Either<L, R> {
  final L _failure;

  const Left(this._failure);

  @override
  void fold({
    void Function(R value)? right,
    void Function(L value)? left,
  }) {
    left?.call(_failure);
  }
}
