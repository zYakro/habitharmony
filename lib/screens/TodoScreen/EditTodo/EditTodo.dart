import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Todo.dart';
import 'package:flutter_audio_service_demo/screens/TodoScreen/TodoPlaylist/TodoPlaylist.dart';
import 'package:flutter_audio_service_demo/widgets/FirstArtwork/FirstArtwork.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class EditTodo extends StatefulWidget {
  final Todo todo;

  const EditTodo({super.key, required this.todo});

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  HabitsManager habitsManager = getIt<HabitsManager>();
  late Todo todoCopy;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    todoCopy = widget.todo;
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController =
        TextEditingController(text: widget.todo.description);
  }

  void updateTitle(Todo todo) {
    habitsManager.setNewTodoTitle(todo, _titleController.text);
  }

  void updateDescription(Todo todo) {
    habitsManager.setNewTodoDescription(todo, _descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Upper bar with 'Habits'
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.expand_less,
              size: 25,
              color: Theme.of(context).iconTheme.color,
            )),
        actions: [
          TextButton(
            onPressed: () {
              habitsManager.deleteTodo(widget.todo);
              Navigator.of(context).pop();
            },
            child: Text('Delete',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground)),
          ),
        ],
      ),
      // Main part
      body: ValueListenableBuilder<List<Todo>>(
        valueListenable: habitsManager.todoList,
        builder: (context, todoList, _) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
              child: ListView(children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FirstArtwork(playlist: todoCopy.playlist),
                          Container(
                              width: 150,
                              height: 170,
                              child: Center(
                                child: WillPopScope(
                                  onWillPop: () async {
                                    updateTitle(todoCopy);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    return true;
                                  },
                                  child: TextFormField(
                                    maxLines: null,
                                    onTapOutside: (event) {
                                      updateTitle(todoCopy);
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    onFieldSubmitted: (text) {
                                      updateTitle(todoCopy);
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    style: const TextStyle(fontSize: 25),
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                      ),
                                    ),
                                    controller: _titleController,
                                  ),
                                ),
                              ))
                        ])),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: WillPopScope(
                    onWillPop: () async {
                      updateDescription(todoCopy);
                      FocusManager.instance.primaryFocus?.unfocus();
                      return true;
                    },
                    child: TextFormField(
                      onTapOutside: (event) {
                        updateDescription(todoCopy);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onFieldSubmitted: (text) {
                        updateDescription(todoCopy);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: TodoPlaylist(
                      todo: todoCopy,
                    )),
              ]),
            ),
          );
        },
      ),
    );
  }
}
