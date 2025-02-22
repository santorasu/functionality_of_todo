import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tasks = [];
  bool showActiveTask = true;

  void _showTaskDialog({int? index}) {
    TextEditingController taskController = TextEditingController(
      text: index != null ? tasks[index]['task'] : '',
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index != null ? 'Edit Task' : "Add Task"),
        content: TextField(
          controller: taskController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter Task',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (taskController.text.trim().isNotEmpty) {
                if (index == null) {
                  _addTask(taskController.text);
                } else {
                  _editTask(index, taskController.text);
                }
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _addTask(String task) {
    setState(() {
      tasks.add({'task': task, 'completed': false});
    });
    Navigator.pop(context);
  }

  void _toggleTask(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _editTask(int index, String updateTask) {
    setState(() {
      tasks[index]['task'] = updateTask;
    });
    Navigator.pop(context);
  }

  int get activeCount => tasks.where((task) => !task['completed']).length;
  int get completedCount => tasks.where((task) => task['completed']).length;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTasks =
    tasks.where((task) => task['completed'] == !showActiveTask).toList();

    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text("TODO LIST"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      showActiveTask = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: showActiveTask ? Colors.purple : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: showActiveTask ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          activeCount.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: showActiveTask ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      showActiveTask = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: !showActiveTask ? Colors.purple : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: !showActiveTask ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          completedCount.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: !showActiveTask ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                int originalIndex = tasks.indexOf(filteredTasks[index]);
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      _toggleTask(originalIndex);
                    } else {
                      _deleteTask(originalIndex);
                    }
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        filteredTasks[index]['task'],
                        style: TextStyle(
                          fontSize: 16,
                          decoration: filteredTasks[index]['completed']
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      leading: Checkbox(
                        shape: const CircleBorder(),
                        value: filteredTasks[index]['completed'],
                        onChanged: (value) => _toggleTask(originalIndex),
                      ),
                      trailing: IconButton(
                        onPressed: () => _showTaskDialog(index: originalIndex),
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
