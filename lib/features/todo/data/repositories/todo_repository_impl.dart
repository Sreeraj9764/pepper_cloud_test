import 'package:pepper_cloud_test/core/app_core.dart';
import 'package:pepper_cloud_test/features/todo/data/datasources/local/todo_local_data_source.dart';
import 'package:pepper_cloud_test/features/todo/data/models/todo_model.dart';
import 'package:pepper_cloud_test/features/todo/domain/entities/todo.dart';
import 'package:pepper_cloud_test/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource dataSource;

  TodoRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, void>> deleteTodo({required String id}) async {
    try {
      await dataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return const Left(ClientFailure(message: "Unable to delete.."));
    }
  }

  @override
  Stream<List<Todo>> getTodos() {
    try {
      return dataSource.getTodos();
    } catch (e) {
      throw const ClientException(message: "Cant't get todos..");
    }
  }

  @override
  Future<Either<Failure, void>> saveTodo({required Todo todo}) async {
    try {
      await dataSource.saveTodo(TodoModel(
          title: todo.title,
          description: todo.description,
          id: todo.id,
          isCompleted: todo.isCompleted,
          dateTime: DateTime.now()));
      return const Right(null);
    } catch (e) {
      return const Left(ClientFailure(message: "Unable to save.."));
    }
  }
}
