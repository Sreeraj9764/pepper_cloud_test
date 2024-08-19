abstract class Either<L, R> {
  const Either();

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  L get left => throw StateError('No such case!');
  R get right => throw StateError('No such case!');

  Either<R, L> swap();

  E fold<E>(E Function(L) onLeft, E Function(R) onRight);
  T match<T>(T Function(L) onLeft, T Function(R) onRight);
}

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  L get left => value;

  @override
  Either<R, L> swap() => Right(value);

  @override
  E fold<E>(E Function(L) onLeft, _) => onLeft(value);

  @override
  T match<T>(T Function(L) onLeft, _) => onLeft(value);
}

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  R get right => value;

  @override
  Either<R, L> swap() => Left(value);

  @override
  E fold<E>(_, E Function(R) onRight) => onRight(value);

  @override
  T match<T>(_, T Function(R) onRight) => onRight(value);
}
