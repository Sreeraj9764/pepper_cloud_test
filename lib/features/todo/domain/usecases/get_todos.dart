import 'package:pepper_cloud_test/core/error/failure.dart';
import 'package:pepper_cloud_test/core/resources/either.dart';
import 'package:pepper_cloud_test/core/usecase/usecase.dart';
import 'package:pepper_cloud_test/features/todo/domain/entities/todo.dart';
import 'package:pepper_cloud_test/features/todo/domain/repositories/todo_repository.dart';

class GetTodos implements UseCase<Stream<List<Todo>>, NoParams> {
  final TodoRepository todoRepository;

  GetTodos({required this.todoRepository});
  @override
  Future<Either<Failure, Stream<List<Todo>>>> call(NoParams params) async {
    return await todoRepository.getTodos();
  }
}
