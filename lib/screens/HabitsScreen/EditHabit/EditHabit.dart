import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Habit.dart';
import 'package:flutter_audio_service_demo/widgets/FirstArtwork/FirstArtwork.dart';
import 'package:flutter_audio_service_demo/screens/HabitsScreen/HabitPlaylist/HabitPlaylist.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class EditHabit extends StatefulWidget {
  final Habit habit;

  const EditHabit({super.key, required this.habit});

  @override
  _EditHabitState createState() => _EditHabitState();
}

class _EditHabitState extends State<EditHabit> {
  HabitsManager habitsManager = getIt<HabitsManager>();
  late Habit habitCopy;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    habitCopy = widget.habit;
    _titleController = TextEditingController(text: widget.habit.title);
    _descriptionController =
        TextEditingController(text: widget.habit.description);
  }

  void updateTitle(Habit habitToEdit) {
    habitsManager.setNewHabitTitle(habitToEdit, _titleController.text);
  }

  void updateDescription(Habit habitToEdit) {
    habitsManager.setNewHabitDescription(
        habitToEdit, _descriptionController.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
              habitsManager.deleteHabit(widget.habit);
              Navigator.of(context).pop();
            },
            child: Text('Delete',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground)),
          ),
        ],
      ),
      // Main part
      body: ValueListenableBuilder<List<Habit>>(
        valueListenable: habitsManager.habitList,
        builder: (context, habitList, _) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
              child: ListView(children: [
                // Input for 'Habit'
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FirstArtwork(playlist: habitCopy.playlist),
                          Container(
                              width: 150,
                              height: 170,
                              child: Center(
                                child: WillPopScope(
                                  onWillPop: () async {
                                    updateTitle(habitCopy);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    return true;
                                  },
                                  child: TextFormField(
                                    onTapOutside: (event) {
                                      updateTitle(habitCopy);
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    onFieldSubmitted: (text) {
                                      updateTitle(habitCopy);
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    maxLines: null,
                                    style: const TextStyle(fontSize: 25),
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ), // Color for inactive state
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ), // Color for inactive state
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
                      updateDescription(habitCopy);
                      FocusManager.instance.primaryFocus?.unfocus();
                      return true;
                    },
                    child: TextFormField(
                      onTapOutside: (event) {
                        updateDescription(habitCopy);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onFieldSubmitted: (text) {
                        updateDescription(habitCopy);
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
                    child: HabitPlaylist(
                      habit: habitCopy,
                    )),
                Container(
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    children: habitCopy.subhabits.map((subHabit) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: EditSubhabit(
                            habit: subHabit,
                            globalHabit: widget.habit,
                          ));
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      habitsManager.addSubhabit(
                          widget.habit,
                          Habit(
                            title: 'New Sub-habit',
                            description: '',
                            isCompleted: false,
                            playlist: [],
                            resetDate: DateTime.now(),
                            subhabits: [],
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).primaryColor, // Background color
                    ),
                    child: Text(
                      'Create Subhabit',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary, // Text color
                        fontSize: 15.0, // Adjust the font size as needed
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class EditSubhabit extends StatefulWidget {
  final Habit habit;
  final Habit globalHabit;

  const EditSubhabit(
      {super.key, required this.habit, required this.globalHabit});

  @override
  State<EditSubhabit> createState() => _EditSubhabitState();
}

class _EditSubhabitState extends State<EditSubhabit> {
  HabitsManager habitsManager = getIt<HabitsManager>();
  bool isExpanded = false;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  void updateTitle(Habit habitToEdit) {
    habitsManager.setNewHabitTitle(habitToEdit, _titleController.text);
  }

  void updateDescription(Habit habitToEdit) {
    habitsManager.setNewHabitDescription(
        habitToEdit, _descriptionController.text);
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.habit.title);
    _descriptionController =
        TextEditingController(text: widget.habit.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
              title: WillPopScope(
                onWillPop: () async {
                  updateTitle(widget.habit);
                  FocusManager.instance.primaryFocus?.unfocus();
                  return true;
                },
                child: TextFormField(
                  controller: _titleController,
                  onTapOutside: (event) {
                    updateTitle(widget.habit);
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onFieldSubmitted: (text) {
                    updateTitle(widget.habit);
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  widget.habit.isCompleted
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                ),
                onPressed: () {
                  habitsManager.setHabitIsCompleted(
                      widget.habit, !widget.habit.isCompleted);
                },
              ),
              trailing: Row(
                  mainAxisSize: MainAxisSize
                      .min, // This ensures that the icons take up minimum space

                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        habitsManager.removeSubHabit(
                            widget.globalHabit, widget.habit);
                      },
                    ),
                    IconButton(
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
                  ])),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Visibility(
              visible: isExpanded,
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 300), // Animation duration
                width: isExpanded ? 500 : 0, // Set the width when expanded
                height: isExpanded ? 329 : 0, // Set the height when expanded
                child: Container(
                    color: Theme.of(context).colorScheme.background,
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: WillPopScope(
                          onWillPop: () async {
                            updateDescription(widget.habit);
                            FocusManager.instance.primaryFocus?.unfocus();
                            return true;
                          },
                          child: TextFormField(
                            onTapOutside: (event) {
                              updateDescription(widget.habit);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            onFieldSubmitted: (text) {
                              updateDescription(widget.habit);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            controller: _descriptionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: 200,
                          child: HabitPlaylist(
                            habit: widget.habit,
                          )),
                    ])),
              ),
            ),
          )
        ],
      ),
    );
  }
}
