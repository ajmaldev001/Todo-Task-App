import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_assignment/configs/components/custom_icon_button.dart';
import 'package:todo_assignment/view/widgets/add_item_textfeild.dart';
import 'package:todo_assignment/view/widgets/custom_appbar_widget.dart';
import 'package:todo_assignment/view/widgets/search_item_textfeild.dart';
import 'package:todo_assignment/view_model/todo_list_view_model.dart';
import '../../configs/color/colors.dart';
import '../widgets/todo_item.dart';


class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final todoAddController = TextEditingController();
  final todoEditController = TextEditingController();

  @override
  void initState() {
    var todoListVm = Provider.of<TodoListViewModel>(context,listen: false);
    todoListVm.todoListTask = todoListVm.todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListViewModel>(
        builder: (context,todoListViewModel,child) {
        return Scaffold(
          backgroundColor: AppColor.tdBGColor,
          appBar: AppBar(
            backgroundColor: AppColor.tdBGColor,
            elevation: 0,
            title: const CustomAppBarContents(),
          ),
          body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColor.tdBGColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            /* Filter Item TextFeild */
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SearchItemTextFeild(
                                  onChanged: (value) => todoListViewModel.runFilter(value)),
                                const SizedBox(height: 12),
                                const Text(
                                  'All ToDos',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                            
                            /* Todo Items List */
                            Expanded(
                              child: Container(
                                color: AppColor.tdBGColor,
                                child: ListView.builder(
                                  itemCount: todoListViewModel.todoListTask.length,
                                  itemBuilder: (context, index) => 
                                  /* Todo Items with check box, task and delete icon */
                                  ToDoItem(
                                        todo: todoListViewModel.todoListTask[index],
                                        onToDoChanged: (todo) => todoListViewModel.handleToDoChange(todo,index),
                                        onDeleteItem: (value) => todoListViewModel.deleteToDoItem(index),
                                        onLongPress: () {
                                          todoAddController.text = todoListViewModel.todoListTask[index].todoText ?? '';
                                          todoListViewModel.onEditItems(index, todoAddController.text);
                                        } 
                                    ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 60)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                /* Add New Item  */
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                    
                    /* Add Todo Item Text */
                    Expanded(
                      child: AddItemTextFeild(
                        controller: todoAddController)
                    ),
                    
                    /* Add Item Button */
                    CustomIconButtom(
                      onPressed: (){
                        todoListViewModel.addToDoItem(todoAddController.text);
                        todoAddController.clear();
                      }, 
                      padding: 20,
                      backgroundColor: 
                      todoListViewModel.isEditable 
                      ? AppColor.tdGreen
                      : AppColor.tdBlue,
                      fontColor: AppColor.tdWhite, 
                      size: 60,
                      fontSize: 30, 
                      icon: 
                      todoListViewModel.isEditable
                      ? const Icon(
                        Icons.check,
                        size: 30, 
                        color: AppColor.tdWhite
                      )
                      : const Icon(
                        Icons.add, 
                        size: 30, 
                        color: AppColor.tdWhite
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}