import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String sectionName;
  final String text;
  const MyTextBox({super.key, required this.sectionName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey[200],
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(sectionName),
        Text(text),
      ],
     ),
    );
  }
}