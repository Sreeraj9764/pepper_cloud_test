import 'package:pepper_cloud_test/core/app_core.dart';
import 'package:pepper_cloud_test/core/usecase/usecase.dart';
import 'package:pepper_cloud_test/features/todo/domain/entities/todo.dart';
import 'package:pepper_cloud_test/features/todo/domain/repositories/todo_repository.dart';

class SaveTodo implements UseCase<void, Todo> {
  final TodoRepository todoRepository;

  SaveTodo({required this.todoRepository});
  @override
  Future<Either<Failure, void>> call(Todo todo) async {
    return await todoRepository.saveTodo(todo: todo);
  }
}
