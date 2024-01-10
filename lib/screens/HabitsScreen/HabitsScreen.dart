import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Habit.dart';
import 'package:flutter_audio_service_demo/screens/HabitsScreen/CreateHabit/CreateHabit.dart';
import 'package:flutter_audio_service_demo/screens/HabitsScreen/HabitItem/HabitItem.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/DailyQuote/DailyQuote.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen>
    with AutomaticKeepAliveClientMixin<HabitsScreen> {
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
        title: Text('Habits',
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: IconButton(
            icon: Icon(Icons.home, color: Theme.of(context).iconTheme.color),
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
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.background,
                    child: ValueListenableBuilder<List<Habit>>(
                        valueListenable: habitsManager.habitList,
                        builder: (context, habitList, _) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                            child: Scrollbar(
                              thumbVisibility: true,
                              interactive: true,
                              thickness: 20,
                              child: ListView.builder(
                                itemCount: habitList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child:
                                          HabitItem(habit: habitList[index]));
                                },
                              ),
                            ),
                          );
                        })))
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          habitsManager.addNewHabit(Habit(
            title: 'New habit',
            description: '',
            isCompleted: false,
            resetDate: DateTime.now(),
            subhabits: [],
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
