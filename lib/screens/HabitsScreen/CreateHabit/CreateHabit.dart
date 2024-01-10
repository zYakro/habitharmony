import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Habit.dart';
import 'package:flutter_audio_service_demo/widgets/FirstArtwork/FirstArtwork.dart';
import 'package:flutter_audio_service_demo/screens/HabitsScreen/HabitPlaylist/HabitPlaylist.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';

class CreateHabit extends StatefulWidget {
  const CreateHabit({super.key});

  @override
  State<CreateHabit> createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {
  Habit newHabit = Habit(
      title: '',
      description: '',
      isCompleted: false,
      resetDate: DateTime.now(),
      subhabits: [],
      playlist: []);

  final habitsManager = getIt<HabitsManager>();

  @override
  void initState() {
    habitsManager.addNewHabit(newHabit);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    bool isSaved = false;

    @override
    void dispose() {
      _titleController.dispose();
      _descriptionController.dispose();
      
      super.dispose();
    }

    return WillPopScope(
      onWillPop: () async {
        if(!isSaved){
          habitsManager.deleteHabit(newHabit);
        } 

          print('helou');
        return true;
      },
      child: Scaffold(
        // Upper bar with 'Habits'
        appBar: AppBar(
          title: Text(
            'Create Habit',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0.0,
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Saved!'),
                  ),
                );
                newHabit.title = _titleController.text;
                newHabit.description = _descriptionController.text;
                isSaved = true;
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
              ),
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
                            FirstArtwork(playlist: newHabit.playlist),
                            Container(
                                width: 150,
                                height: 170,
                                child: Center(
                                  child: TextFormField(
                                    maxLines: null,
                                    style: const TextStyle(fontSize: 25),
                                    decoration: InputDecoration(
                                      label: const Text('Title'),
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
                                ))
                          ])),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
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
                  const SizedBox(height: 16),
                  Container(
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: HabitPlaylist(
                        habit: newHabit,
                      )),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
