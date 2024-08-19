import 'package:get_it/get_it.dart';
import 'package:pepper_cloud_test/features/todo/data/datasources/local/todo_local_data_source.dart';
import 'package:pepper_cloud_test/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:pepper_cloud_test/features/todo/domain/repositories/todo_repository.dart';
import 'package:pepper_cloud_test/features/todo/domain/usecases/usecases.dart';
import 'package:pepper_cloud_test/features/todo/presentation/blocs/edit_todo/edit_todo_bloc.dart';
import 'package:pepper_cloud_test/features/todo/presentation/blocs/todo_view/todo_view_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'di_container_init.dart';
