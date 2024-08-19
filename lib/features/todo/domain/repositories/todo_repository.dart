import 'package:pepper_cloud_test/core/app_core.dart';
import 'package:pepper_cloud_test/features/todo/domain/entities/todo.dart';

abstract interface class TodoRepository {
  Future<Either<Failure, Stream<List<Todo>>>> getTodos();
  Future<Either<Failure, void>> saveTodo({required Todo todo});
  Future<Either<Failure, void>> deleteTodo({required String id});
}
