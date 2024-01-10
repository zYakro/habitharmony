// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/screens/HabitsScreen/EditHabit/EditHabit.dart';
import 'package:flutter_audio_service_demo/screens/HabitsScreen/HabitPlaylist/HabitPlaylist.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/widgets/TaskRewardSnackbar/TaskRewardSnackbar.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import '../../../models/Habit.dart';

class HabitItem extends StatefulWidget {
  final Habit habit;

  const HabitItem({super.key, required this.habit});

  @override
  _HabitItemState createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  HabitsManager habitsManager = getIt<HabitsManager>();
  PetManager petManager = getIt<PetManager>();
  bool isExpanded = false;

  void showEditHabitModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return EditHabit(habit: widget.habit);
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
            title: Text(widget.habit.title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground)),
            leading: Bounce(
              duration: const Duration(milliseconds: 100),
              child: Icon(
                  widget.habit.isCompleted
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                habitsManager.setHabitIsCompleted(
                    widget.habit, !widget.habit.isCompleted);
                petManager.setExp(widget.habit.isCompleted); 
                showTaskRewardSnackbar(widget.habit.isCompleted, 'habit', context);
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
              showEditHabitModal(context);
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
                    child: HabitPlaylist(
                      habit: widget.habit,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
