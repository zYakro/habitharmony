// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Todo.dart';
import 'package:flutter_audio_service_demo/screens/TodoScreen/EditTodo/EditTodo.dart';
import 'package:flutter_audio_service_demo/screens/TodoScreen/TodoPlaylist/TodoPlaylist.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/TaskRewardSnackbar/TaskRewardSnackbar.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  HabitsManager habitsManager = getIt<HabitsManager>();
  PetManager petManager = getIt<PetManager>();
  bool isExpanded = false;

  void showEditTodoModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return EditTodo(todo: widget.todo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            title: Text(widget.todo.title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    decoration: widget.todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none
                    )),
            leading: Bounce(
              duration: Duration(milliseconds: 100),
              child: Icon(
                  widget.todo.isCompleted
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                habitsManager.setTodoIsCompleted(
                    widget.todo, !widget.todo.isCompleted);
                petManager.setExp(widget.todo.isCompleted);
                showTaskRewardSnackbar(widget.todo.isCompleted, 'todo', context);
              },
            ),
            trailing: IconButton(
              icon: isExpanded
                  ? Icon(
                      Icons.expand_less,
                      color: Theme.of(context).iconTheme.color,
                    )
                  : Icon(
                      Icons.expand_more,
                      color: Theme.of(context).iconTheme.color,
                    ),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
            onTap: () {
              showEditTodoModal(context);
            },
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Visibility(
              visible: isExpanded,
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 300), // Animation duration
                width: isExpanded ? 500 : 0, // Set the width when expanded
                height: isExpanded ? 300 : 0, // Set the height when expanded
                child: Container(
                    color: Theme.of(context).colorScheme.background,
                    padding: const EdgeInsets.all(16),
                    child: TodoPlaylist(
                      todo: widget.todo,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
