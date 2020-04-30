import 'package:flutter/cupertino.dart';
import 'package:todoblockstreambuilder/model/todo_model.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  Todo todo = Todo();
  AddTodoEvent({@required this.todo});
}

class DeleteTodoEvent extends TodoEvent {
  int index;
  DeleteTodoEvent({@required this.index});
}

class ToggleTodoEvent extends TodoEvent {
  int index;
  ToggleTodoEvent({@required this.index});
}
