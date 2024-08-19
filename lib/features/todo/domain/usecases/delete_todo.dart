import 'package:pepper_cloud_test/core/error/failure.dart';
import 'package:pepper_cloud_test/core/resources/either.dart';
import 'package:pepper_cloud_test/core/usecase/usecase.dart';
import 'package:pepper_cloud_test/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodo implements UseCase<void, String> {
  final TodoRepository todoRepository;

  DeleteTodo({required this.todoRepository});
  @override
  Future<Either<Failure, void>> call(String id) async {
    return await todoRepository.deleteTodo(id: id);
  }
}
