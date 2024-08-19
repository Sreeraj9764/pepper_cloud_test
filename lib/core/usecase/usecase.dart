import 'package:flutter/material.dart';
import 'package:pepper_cloud_test/core/app_core.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

@immutable
class NoParams {}
