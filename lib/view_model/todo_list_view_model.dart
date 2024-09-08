import 'package:flutter/material.dart';
import 'package:todo_assignment/data/local/shared_pref_util.dart';
import 'package:todo_assignment/model/todo.dart';

class TodoListViewModel extends ChangeNotifier{

  List<ToDo> todosList = ToDo.todoList();
  List<ToDo> todoListTask = [];
  
  Map<int,dynamic> keyItems = {};
  
  bool _isEditable = false;
  bool get isEditable => _isEditable;

  int selectedId = 0;

  /* To load initial data */
  TodoListViewModel() {
    todosList.clear();
    todoListTask.clear();
      SharedPreferencesUtil.getLength("count").then((value) async {
        int initialLength = value;
        debugPrint('initialLength: $initialLength');

        for (int i = 0; i < initialLength; i++) {
          String text = await SharedPreferencesUtil.getString('task_$i');
          bool selectedValue = await SharedPreferencesUtil.getBool('done_$i');
          debugPrint('text: $text');
            ToDo todo = ToDo(
              id: i,
              todoText: text,
              isDone: selectedValue,
            );
            
            keyItems[i] = todo;
            todosList.add(todo);
        }

        todoListTask = todosList;
        notifyListeners();
      });
    
    debugPrint('KeyItems TodoListViewModel(): $keyItems');
  }


  Future<void> addToDoItem(String toDo) async {
    if (!_isEditable) {
      keyItems[0] = ToDo(
        id: 0,
        todoText: toDo.isNotEmpty ? toDo : "New Item",
      );
      todosList.insert(0, keyItems[0]);  // Insert at the beginning
      todoListTask = todosList;

      await SharedPreferencesUtil.setString('task_0', toDo.isNotEmpty ? toDo : "New Item");
      await SharedPreferencesUtil.setLength("count", todoListTask.length);

    } else {
      keyItems[selectedId] = ToDo(id: selectedId, todoText: toDo);
      todosList[selectedId] = keyItems[selectedId];
      todoListTask = todosList;

      await SharedPreferencesUtil.setString('task_$selectedId', toDo.isNotEmpty ? toDo : "New Item");
      await SharedPreferencesUtil.setLength("count", todoListTask.length);
    }
    _isEditable = false;
    notifyListeners();
  }

  
  Future<void> handleToDoChange(ToDo todo, int index) async {
    todo.isDone = !todo.isDone;
    await SharedPreferencesUtil.setBool('done_$index', todo.isDone);
    
    bool getboolFromSp = await SharedPreferencesUtil.getBool('done_$index');
    debugPrint('getboolFromSp: $getboolFromSp');
    notifyListeners();
  }

  void onEditItems(int index, String text){
    _isEditable = true;
    selectedId = index;
    notifyListeners();
  }


    // Delete To-Do item and adjust IDs
  void deleteToDoItem(int id) async {
    keyItems.remove(id);
    todosList.removeAt(id);  // Remove the item from the list
    
    // Reorder IDs after deletion
    Map<int, ToDo> updatedItems = {};
    for (int i = 0; i < todosList.length; i++) {
      updatedItems[i] = todosList[i];
      await SharedPreferencesUtil.setString('task_$i', todosList[i].todoText!);  // Update SharedPreferences
      await SharedPreferencesUtil.setBool('done_$i', todosList[i].isDone);  // Update boolean status
    }

    keyItems = updatedItems;
    await SharedPreferencesUtil.setLength("count", todosList.length);
    todoListTask = todosList;
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    debugPrint('enteredKeyword $enteredKeyword');
    if (enteredKeyword.isEmpty) {
      todoListTask = todosList;
    } else {
      todoListTask = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
          debugPrint('foundToDo: $todoListTask');
    }
    notifyListeners();
  }


}