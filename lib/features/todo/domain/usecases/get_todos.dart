import 'package:pepper_cloud_test/core/usecase/usecase.dart';
import 'package:pepper_cloud_test/features/todo/domain/entities/todo.dart';
import 'package:pepper_cloud_test/features/todo/domain/repositories/todo_repository.dart';

class GetTodos {
  final TodoRepository todoRepository;

  GetTodos({required this.todoRepository});

  Stream<List<Todo>> call(NoParams params) {
    return todoRepository.getTodos();
  }
}
