import 'package:flutter/material.dart';

import '../models/card_data_model.dart';

class TaskManagementProvider with ChangeNotifier{


  List<CardDataModel> tasks = [
    CardDataModel(title: "Task 1", subtitle: "This is the first task", id: '1', icon: null),
    CardDataModel(title: "Task 2", subtitle: "This is the second task", icon: Icons.abc_rounded, id: '2'),
    CardDataModel(title: "Task 3", subtitle: "This is the third task", icon: Icons.account_balance, id: '3'),
    CardDataModel(title: "Task 4", subtitle: "This is the fourth task", icon: Icons.add, id: '4'),
    CardDataModel(title: "Task 5", subtitle: "This is the fifth task", icon: Icons.delete, id: '5'),
    CardDataModel(title: "Task 6", subtitle: "Custom TASK", icon: Icons.edit, id: '6'),
  ];

  void addTaskExternal(CardDataModel task){
    tasks.add(task);
    notifyListeners();  
  }


  void printTaskCount(){
    print("Total tasks: ${tasks.length}");
  }


  void addTaskAuto(){
    tasks.add(
      CardDataModel(
        title: "Task ${tasks.length + 1}",
        subtitle: "This is task ${tasks.length + 1}",
        icon: Icons.auto_fix_normal, id: ''
      )
    );

    print("Added Task ${tasks.length}");
    print(tasks.last);
    notifyListeners();
  }
}