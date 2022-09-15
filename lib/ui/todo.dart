import 'package:flutter/material.dart';
import 'package:flutter_exam/router/router_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// model
@immutable
class Todo {
  const Todo(
      {required this.id, required this.description, required this.completed});

  final String id;
  final String description;
  final bool completed;

  Todo copyWith({String? id, String? description, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}

// repository
class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([]);
  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});

final completedTodosProvider = Provider<List<Todo>>((ref) {
  // We obtain the list of all todos from the todosProvider
  final todos = ref.watch(todosProvider);

  // we return only the completed todos
  return todos.where((todo) => todo.completed).toList();
});

class TodoListView extends ConsumerWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // rebuild the widget when the todo list changes
    List<Todo> todos = ref.watch(todosProvider);

    // Let's render the todos in a scrollable list view
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.go(context.namedLocation(RouterName.home));
            },
            child: const Text('Go to home'),
          ),
          ElevatedButton(
            onPressed: () =>
                ref.read(todosProvider.notifier).addTodo(const Todo(
                      id: 'test',
                      description: 'test',
                      completed: true,
                    )),
            child: const Text('add Todo'),
          ),
          ListView(shrinkWrap: true, children: [
            for (final todo in todos)
              CheckboxListTile(
                value: todo.completed,
                // When tapping on the todo, change its completed status
                onChanged: (value) =>
                    ref.read(todosProvider.notifier).toggle(todo.id),
                title: Text(todo.description),
              ),
          ])
        ],
      ),
    );
  }
}


// future provider
