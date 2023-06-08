import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String user;
  final String text;
  final String time;
  const Comment(
      {super.key, 
      required this.user, 
      required this.text, 
      required this.time,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(text),

          Row(
            children: [
              Text(user),
            ],
          )
        ],
      ),
    );
  }
}
