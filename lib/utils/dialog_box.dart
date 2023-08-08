import 'package:flutter/material.dart';

import 'package:notes_app/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCanel;

  DialogBox(
      {super.key,
      this.controller,
      required this.onSave,
      required this.onCanel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.orange[200],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: ("Add a new task"),
              ),
            ),

            //buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Save", onPressed: onSave),
                const SizedBox(
                  width: 8,
                ),
                MyButton(text: "Cancel", onPressed: onCanel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
