// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/models/Habit.dart';
import 'package:flutter_audio_service_demo/models/Todo.dart';
import 'package:flutter_audio_service_demo/services/service_locator.dart';
import 'package:flutter_audio_service_demo/services/shop_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitsManager {
  final habitList = ValueNotifier<List<Habit>>([]);
  final todoList = ValueNotifier<List<Todo>>([]);
  ShopManager shopManager = getIt<ShopManager>();

  final todos = [
    Todo(
      title: 'Workout',
      description: 'Morning meditation practice',
      resetDate: DateTime.now(),
      playlist: ['content://media/external/audio/media/1000000616'],
      isCompleted: false,
    ),
    Todo(
      title: 'Exercise',
      description: 'Daily workout routine',
      resetDate: DateTime.now(),
      playlist: [],
      isCompleted: false,
    )
  ];

  Habit addNewHabit(Habit habit) {
    habitList.value = [...habitList.value, habit];
    saveHabitsToLocalStorage();
    return habit;
  }

  Habit addSubhabit(Habit habit, Habit subhabit) {
    habit.subhabits = [...habit.subhabits, subhabit];
    habitList.notifyListeners();
    saveHabitsToLocalStorage();
    return subhabit;
  }

  void removeSubHabit(Habit habit, Habit subhabit) {
    habit.removeSubhabit(subhabit);
    habitList.notifyListeners();

    saveHabitsToLocalStorage();
  }

  void setNewHabitTitle(Habit habit, String newTitle) {
    habit.setNewTitle(newTitle);
    habitList.notifyListeners();

    saveHabitsToLocalStorage();
  }

  void deleteHabit(Habit habitToRemove) {
    habitList.value =
        habitList.value.where((habit) => habit != habitToRemove).toList();
    habitList.notifyListeners();

    saveHabitsToLocalStorage();
  }

  void setNewHabitDescription(Habit habit, String newDescription) {
    habit.setNewDescription(newDescription);
    habitList.notifyListeners();

    saveHabitsToLocalStorage();
  }

  void setHabitIsCompleted(Habit habit, bool newIsCompletedValue) {
    habit.setIsCompleted(newIsCompletedValue);

    shopManager.onCompleteHabit(newIsCompletedValue);

    habitList.notifyListeners();

    saveHabitsToLocalStorage();
  }

  void reorderHabitPlaylist(Habit habit, int oldIndex, int newIndex) {
    habit.reorderPlaylist(oldIndex, newIndex);
    saveHabitsToLocalStorage();
    habitList.notifyListeners();
  }

  void rewriteHabitPlaylist(Habit habit, List<String> newPlaylist) {
    habit.playlist = newPlaylist;
    saveHabitsToLocalStorage();
    habitList.notifyListeners();
  }

  Future<void> saveHabitsToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final encodedHabits =
        habitList.value.map((habit) => habit.toJson()).toList();
    final habitsJson = jsonEncode(encodedHabits);
    await prefs.setString('habits', habitsJson);
  }

  Future<void> getHabitsFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? habitsString = prefs.getString('habits');

    if (habitsString != null) {
      final List<dynamic> decodedHabits =
          jsonDecode(habitsString) as List<dynamic>;
      habitList.value = decodedHabits
          .map((habitJson) => Habit.fromJson(habitJson as Map<String, dynamic>))
          .toList();
    }
  }

  // Todo list

  Todo addNewTodo(Todo todo) {
    todoList.value = [todo, ...todoList.value];
    saveTodosToLocalStorage();
    return todo;
  }

  void setNewTodoTitle(Todo todo, String newTitle) {
    todo.setNewTitle(newTitle);
    todoList.notifyListeners();
    saveTodosToLocalStorage();
  }

  void deleteTodo(Todo todoToRemove) {
    todoList.value =
        todoList.value.where((todo) => todo != todoToRemove).toList();
    habitList.notifyListeners();
    saveTodosToLocalStorage();
  }

  void setNewTodoDescription(Todo todo, String newDescription) {
    todo.setNewDescription(newDescription);
    saveTodosToLocalStorage();
    todoList.notifyListeners();
  }

  void setTodoIsCompleted(Todo todo, bool newIsCompletedValue) {
    todo.setIsCompleted(newIsCompletedValue);
    shopManager.onCompleteTodo(newIsCompletedValue);
    saveTodosToLocalStorage();
    todoList.notifyListeners();
  }

  void reorderTodoPlaylist(Todo todo, int oldIndex, int newIndex) {
    todo.reorderPlaylist(oldIndex, newIndex);
    saveTodosToLocalStorage();
    todoList.notifyListeners();
  }

  void rewriteTodoPlaylist(Todo todo, List<String> newPlaylist) {
    todo.playlist = newPlaylist;
    saveTodosToLocalStorage();
    todoList.notifyListeners();
  }

  Future<void> saveTodosToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final encodedTodos = todoList.value.map((todo) => todo.toJson()).toList();
    final todosJson = jsonEncode(encodedTodos);
    await prefs.setString('todos', todosJson);
  }

  Future<void> getTodosFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');

    if (todosString != null) {
      final List<dynamic> decodedTodos =
          jsonDecode(todosString) as List<dynamic>;
      todoList.value = decodedTodos
          .map((todoJson) => Todo.fromJson(todoJson as Map<String, dynamic>))
          .toList();
    }
  }

  void resetAllHabits() {
    for (var habit in habitList.value) {
      habit.resetIfNecessary();
    }
    habitList.notifyListeners();
  }

  void init() async {
    await getHabitsFromLocalStorage();
    await getTodosFromLocalStorage();
    resetAllHabits();
  }
}
