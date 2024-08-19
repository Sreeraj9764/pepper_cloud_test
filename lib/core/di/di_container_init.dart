part of 'di_container.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await _initPref();
  _initTodo();
}

Future<void> _initPref() async {
  sl.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
  await GetIt.instance.isReady<SharedPreferences>();
}

void _initTodo() {
  //Datasoure
  sl.registerFactory<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(prefs: sl()),
  );
  //Repository
  sl.registerFactory<TodoRepository>(
    () => TodoRepositoryImpl(
      dataSource: sl(),
    ),
  );
  //Usecases
  sl
    ..registerFactory(() => DeleteTodo(todoRepository: sl()))
    ..registerFactory(() => GetTodos(todoRepository: sl()))
    ..registerFactory(() => SaveTodo(todoRepository: sl()));

  //Bloc
  sl
    ..registerLazySingleton(
        () => TodosViewBloc(deleteTodo: sl(), getTodos: sl(), saveTodo: sl()))
    ..registerFactory(() => EditTodoBloc(saveTodo: sl()));
}
