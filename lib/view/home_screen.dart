import 'package:flutter/material.dart';
//imported provider package
import 'package:provider/provider.dart';
//imported provider page
import '../notifier/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //keys of form widget------------------------------------------------------------------------------------------------------->
  final _addKey = GlobalKey<FormState>();
  final _updateKey = GlobalKey<FormState>();
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
          //theme button------------------------------------------------------------------------------------------------------>
          IconButton(
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
            icon: Icon(Icons.brightness_6),
          ),
        ],
      ),
      //task adding button---------------------------------------------------------------------------------------------------->
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                content: Form(
                  key: _addKey,
                  child: TextFormField(
                    controller: task.taskController,
                    decoration: InputDecoration(
                      labelText: "Write task",
                      border: OutlineInputBorder(),
                    ),
                    //form validate here ------------------------------------------------------------------------------------------>
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter a task";
                      }
                      return null;
                    },
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
                        ),
                        onPressed: () {
                          if (_addKey.currentState!.validate()) {
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
      //the body starts here ----------------------------------------------------------------------------------------------------->
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            if (taskProvider.tasks.isEmpty) {
              return Center(
                child: Text(
                  "No Task",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              );
            }
            return Column(
              children: [
                //total task count shows here------------------------------------------------------------------------------------->
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total: ${taskProvider.tasks.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(width: 20), // space between texts
                      Text(
                        "Completed: ${taskProvider.completedTaskCount}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Pending: ${taskProvider.pendingTaskCount}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                //tasks show here------------------------------------------------------------------------------------------------->
                Expanded(
                  child: ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          taskProvider.tasks[index].title,
                          style: TextStyle(
                            decoration: taskProvider.tasks[index].isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        //status of task shows here-------------------------------------------------------------------------------->
                        leading: Checkbox(
                          value: taskProvider.tasks[index].isCompleted,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            context.read<TaskProvider>().toggleStatus(index);
                          },
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //edit button is here----------------------------------------------------------------------------------->
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                final editController = TextEditingController(
                                  text: taskProvider.tasks[index].title,
                                );
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Center(
                                        child: Text(
                                          "Edit Task",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      content: Form(
                                        key: _updateKey,
                                        child: TextFormField(
                                          controller: editController,
                                          decoration: InputDecoration(
                                            labelText: "Update task",
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Please enter updated task";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: Colors.indigo,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel"),
                                            ),
                                            SizedBox(width: 20),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: Colors.indigo,
                                              ),
                                              onPressed: () {
                                                if (_updateKey.currentState!
                                                    .validate()) {
                                                  context
                                                      .read<TaskProvider>()
                                                      .updateTask(
                                                        index,
                                                        editController.text,
                                                      );
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Text("Update"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            //delete button goes here--------------------------------------------------------------------------------->
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                taskProvider.removeTask(index);
                              },
                            ),
                          ],
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
