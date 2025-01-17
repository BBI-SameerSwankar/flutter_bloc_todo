import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_bloc_app/features/todo/data/data_sources/todo_local_data_source.dart';
import 'package:todo_bloc_app/features/todo/data/repository/todo_repository_impl.dart';
import 'package:todo_bloc_app/features/todo/domain/respository/todo_respositories.dart';
import 'package:todo_bloc_app/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_bloc_app/features/todo/domain/usecases/delete_todo_by_id.dart';
import 'package:todo_bloc_app/features/todo/domain/usecases/edit_todo.dart';
import 'package:todo_bloc_app/features/todo/domain/usecases/get_all_todos.dart';
import 'package:todo_bloc_app/features/todo/presentation/bloc/todo_bloc.dart';



final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize SharedPreferences asynchronously
  final sharedPreferences = await SharedPreferences.getInstance();

  // Register dependencies
  locator.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  locator.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(todoLocalDataSource: locator()));

  // Register use cases
  locator.registerLazySingleton<AddTodo>(() => AddTodo(locator()));
  locator.registerLazySingleton<DeleteTodo>(() => DeleteTodo(locator()));
  locator.registerLazySingleton<EditTodo>(() => EditTodo(locator()));
  locator.registerLazySingleton<GetAllTodos>(() => GetAllTodos(locator()));

  // Register TodoBloc (factory for fresh instances)
  locator.registerFactory<TodoBloc>(() => TodoBloc(
    addTodoUseCase: locator(),
    deleteTodoUseCase: locator(),
    editTodoUseCase: locator(),
    getAllTodosUseCase: locator(),
  ));
}
