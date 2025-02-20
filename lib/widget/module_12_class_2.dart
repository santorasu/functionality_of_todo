import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          Row(
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SizedBox(height: 20,),
              // ),
              // ListTile(
              //   title: Text("Today"),
              //   trailing: Icon(Icons.arrow_forward_ios),
              //   onTap: (){},
              // )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
