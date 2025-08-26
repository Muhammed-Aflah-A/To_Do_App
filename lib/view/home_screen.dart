import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifier/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final task = context.watch<TaskProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-Do App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
            icon: Icon(Icons.brightness_6),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          // side: BorderSide(color: Colors.white, width: 3),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Center(
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                content: TextField(
                  controller: task.taskController,
                  decoration: InputDecoration(
                    labelText: "Write task",
                    prefixIcon: Icon(Icons.task),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo,
                          // side: BorderSide(color: Colors.black, width: 3),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          task.taskController.clear();
                        },
                        child: Text("Cancel"),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo,
                          // side: BorderSide(color: Colors.black, width: 3),
                        ),
                        onPressed: () {
                          if (task.taskController.text.trim().isNotEmpty) {
                            context.read<TaskProvider>().addTask(
                              task.taskController.text,
                            );
                            task.taskController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Add"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            if (taskProvider.tasks.isEmpty) {
              return Center(
                child: Text(
                  "No Task",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Total Tasks: ${taskProvider.tasks.length}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(taskProvider.tasks[index]),
                        // leading: Checkbox(
                        //   activeColor: Colors.green,
                        //   value: checked,
                        //   onChanged: (val) {
                        //     setState(() {
                        //       checked = val;
                        //     });
                        //   },
                        // ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            taskProvider.removeTask(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
