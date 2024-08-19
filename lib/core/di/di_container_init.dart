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
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(prefs: sl()),
  );
  //Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      dataSource: sl(),
    ),
  );
  //Usecases
  sl
    ..registerLazySingleton(() => DeleteTodo(todoRepository: sl()))
    ..registerLazySingleton(() => GetTodos(todoRepository: sl()))
    ..registerLazySingleton(() => SaveTodo(todoRepository: sl()));

  //Bloc
  sl
    ..registerFactory(
        () => TodosViewBloc(deleteTodo: sl(), getTodos: sl(), saveTodo: sl()))
    ..registerFactory(() => EditTodoBloc(saveTodo: sl()));
}
