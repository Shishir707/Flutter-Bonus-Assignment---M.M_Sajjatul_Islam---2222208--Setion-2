import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/dummy_data.dart';
import '../providers/task_management_provider.dart';
import '../widgets/task_card_widget.dart';
import 'add_task_page.dart';

class UiPage extends StatefulWidget {
  const UiPage({super.key});

  @override
  State<UiPage> createState() => _UiPageState();
}

class _UiPageState extends State<UiPage> {



  DummyData dummyDataInstance = DummyData();


  @override
  Widget build(BuildContext context) {
    print("Building UI Page...");


    return Scaffold(
      appBar: AppBar(
        title: Text("UI PAGE"),
        backgroundColor: Colors.purpleAccent,
      ),

      body: Consumer<TaskManagementProvider>(
        builder: (context, taskProvider, _) {
          return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];

                return TaskCardWidget(
                  title: task.title,
                  subtitle: task.subtitle,
                  icon: task.icon,
                );
              },
            ),
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddTaskPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purpleAccent,
      ),
    );
  }
}
