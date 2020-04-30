import 'package:flutter/material.dart';
import 'package:todoblockstreambuilder/bloc/todo_bloc.dart';
import 'package:todoblockstreambuilder/bloc/todo_event.dart';

import 'model/todo_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  final _bloc = TodoBloc();
  String itemValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              child: AlertDialog(
                title: Text("Please Add Something"),
                content: TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: "What do you want ?"),
                  onChanged: (val) => itemValue = val,
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _bloc.dispatch(
                        AddTodoEvent(
                          todo: Todo(title: itemValue, isCompleted: false),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            );
          }),
      body: StreamBuilder(
          stream: _bloc.todos,
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snap) {
            if (!snap.hasData) {
              return Center(
                child: Text("Add new todo"),
              );
            }
            return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: InkWell(
                      onDoubleTap: () {
                        _bloc.dispatch(ToggleTodoEvent(index: index));
                      },
                      onLongPress: () {
                        _bloc.dispatch(DeleteTodoEvent(index: index));
                      },
                      child: Text(
                        snap.data[index].title,
                        style: TextStyle(
                          decoration: snap.data[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
