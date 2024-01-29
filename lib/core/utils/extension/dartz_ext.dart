import 'package:dartz/dartz.dart';

extension NullEitherX<L, R> on Either<L, R>? {
  R asRight() => (this?.isRight() == true) ? (this as Right).value : null;

  L asLeft() => (this?.isLeft() == true) ? (this as Left).value : null;
}

extension EitherX<L, R> on Either<L, R> {
  R asRight() => (isRight() == true) ? (this as Right).value : null;

  L asLeft() => (isLeft() == true) ? (this as Left).value : null;
}
