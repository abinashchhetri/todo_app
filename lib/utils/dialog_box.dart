import 'package:flutter/material.dart';
import 'package:todo_app/utils/my_buttions.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 170,
        child: Column(
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // button -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              //save button
              children: [
                MyButton(text: "Save", onPressed: onSave),
                const SizedBox(
                  width: 50,
                ),
                //cancel button
                MyButton(text: "Cancel", onPressed: onCancel)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
