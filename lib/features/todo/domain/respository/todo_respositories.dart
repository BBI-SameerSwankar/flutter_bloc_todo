import 'package:todo_bloc_app/core/error/failure.dart';
import 'package:todo_bloc_app/features/todo/data/models/todo.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TodoRepository {
  
  Future<Either<Failure, void>> addTodo({
    required Todo todo
  });

  Future<Either<Failure, void>> editTodo({
    required Todo todoInp
  });

  Future<Either<Failure,List<Todo>>> getAllTodos();

  Future<Either<Failure,void>> deleteTodoById({
    required int id
  });


}