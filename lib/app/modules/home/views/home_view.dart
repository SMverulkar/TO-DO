import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Text field for adding new tasks
                  Expanded(
                    child: TextField(
                      controller: controller.textEditingController,
                      decoration: InputDecoration(
                          hintText: 'Enter a new task',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    width:
                        55, // Ensures a square shape by setting both width and height to 50
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor:
                            Colors.blue, // Sets the background color to blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Ensures a square (no rounded corners)
                        ),
                      ),
                      onPressed: () {
                        if (controller.textEditingController.text.isNotEmpty) {
                          controller
                              .addTodo(controller.textEditingController.text);
                          controller.textEditingController.clear();
                        }
                      },
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      ), // Makes the icon white for contrast
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              // Observing the todo list for changes
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.todos.length,
                  itemBuilder: (context, index) {
                    final todo = controller.todos[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      color: todo.isCompleted
                          ? Colors.red.withOpacity(0.15)
                          : Colors.grey.withOpacity(0.3),
                      child: ListTile(
                        leading: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (value) {
                            controller.toggleTodoCompletion(index);
                          },
                        ),
                        title: Text(
                          todo.title.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            controller.productivityPercentage == 100
                ? Container(
                    height: 70,
                    color: Colors.orange
                        .withOpacity(0.01 * controller.productivityPercentage),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Congrulations Your All Task\nAre Complete",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            Container(
              height: 60,
              color: Colors.green
                  .withOpacity(0.01 * controller.productivityPercentage),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Productivity Percentage : ${controller.productivityPercentage.toStringAsFixed(1)}%",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
