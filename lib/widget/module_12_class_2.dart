import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String,dynamic>> tasks = [];
  bool showActiveTask = true;

  void _showTaskDialog({int? index}){
    TextEditingController _taskController = TextEditingController();
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Add Task"),
      content: TextField(
        controller: _taskController,
        decoration: InputDecoration(
          hintText: 'Enter Task',
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel")),
        ElevatedButton(
           style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
             backgroundColor: Colors.purple,
             foregroundColor: Colors.white
        ),
            onPressed: () => _addTask(_taskController.text), child: Text("Save"))
      ],
    ));
  }

  void _addTask(String task){
    setState(() {
      tasks.add(
        {
          'task' : task,
          'completed' : false
        }
      );
    });
    Navigator.pop(context);
  }

  void _toggleTask(int index){
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
  }

  void _deleteTask(int index){
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: Text("TODO LIST"),
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Actice",
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "20",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Completed",
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "20",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context,index){
                  return Dismissible(
                    key: Key(tasks[index]['task']),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,,
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text(tasks[index]['task']),
                      ),
                    ),
                  );
                }
                ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
