import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/modules/home/models/todo_model.dart';

class HomeController extends GetxController {
  // //TODO: Implement HomeController

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {}
  // void increment() => count.value++;

  // List of tasks
  var todos = <Todo>[].obs;

  // Add a new task
  void addTodo(String title) {
    todos.add(Todo(title: title));
  }

  // Toggle the completion status of a task
  void toggleTodoCompletion(int index) {
    todos[index].isCompleted = !todos[index].isCompleted;
    todos.refresh();
  }

  final TextEditingController textEditingController = TextEditingController();

  double get productivityPercentage {
    int totalTasks = todos.length;
    if (totalTasks == 0) return 0.0; // Avoid division by zero

    int completedTasks = todos.where((todo) => todo.isCompleted).length;
    return (completedTasks / totalTasks) * 100;
  }
}
