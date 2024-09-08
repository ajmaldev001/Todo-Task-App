import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_assignment/configs/color/colors.dart';
import 'package:todo_assignment/configs/components/custom_icon_button.dart';

class EditItemBottomSheet extends StatelessWidget {
  const EditItemBottomSheet({
    super.key, required this.controller, required this.onChanged
  });
  final TextEditingController controller;
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Edit Item',style: TextStyle(fontSize: 18)),
              CustomIconButtom(
                onPressed: () {}, 
                padding: 0.0, 
                backgroundColor: AppColor.tdBlue, 
                fontColor: AppColor.tdWhite, 
                size: 40, 
                fontSize: 20, 
                icon: const Icon(
                  Icons.check, 
                  size: 20, 
                  color: AppColor.tdWhite
                ),
              )
            ],
          ),
        ),
        Container(
          color: AppColor.tdWhite,
          height: 140,
          margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 18),
          child: TextFormField(
            expands: true,
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            
            onChanged: onChanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(2000)
            ],
            style: const TextStyle(
              color: AppColor.tdBlack,
              fontSize: 14
            ),
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'What\'s in your mind?',
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppColor.tdBlack,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.tdGrey,
                ),
              ),
              contentPadding:  EdgeInsets.symmetric(
              vertical: 12.0, horizontal: 10),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}