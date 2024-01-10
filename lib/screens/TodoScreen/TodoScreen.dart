import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Todo.dart';
import 'package:flutter_audio_service_demo/screens/HabitsScreen/CreateHabit/CreateHabit.dart';
import 'package:flutter_audio_service_demo/screens/TodoScreen/TodoItem/TodoItem.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/DailyQuote/DailyQuote.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen>
    with AutomaticKeepAliveClientMixin<TodoScreen> {
  HabitsManager habitsManager = getIt<HabitsManager>();

  @override
  bool get wantKeepAlive => true;

  void showCreateHabitModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return const CreateHabit();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do\'s',
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: IconButton(
            icon:
                Icon(Icons.task_alt, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            DailyQuote(),
            Expanded(
                flex: 9,
                child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: ValueListenableBuilder<List<Todo>>(
                        valueListenable: habitsManager.todoList,
                        builder: (context, todoList, _) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                            child: ListView.builder(
                              itemCount: todoList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: TodoItem(todo: todoList[index]));
                              },
                            ),
                          );
                        })))
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          habitsManager.addNewTodo(Todo(
            title: 'New To Do',
            description: '',
            isCompleted: false,
            resetDate: DateTime.now(),
            playlist: [],
          ));
        },
        backgroundColor:
            Theme.of(context).splashColor, // Background color of the button
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
