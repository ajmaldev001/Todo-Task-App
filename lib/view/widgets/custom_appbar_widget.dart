import 'package:flutter/material.dart';
import 'package:todo_assignment/configs/color/colors.dart';

class CustomAppBarContents extends StatelessWidget {
  const CustomAppBarContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        const Icon(
          Icons.menu,
          color: AppColor.tdBlack,
          size: 30,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        ),
      ]
    );
  }
}