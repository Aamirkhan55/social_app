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
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                user,
                style: TextStyle(
                  color: Colors.grey[400],
                  ),
                ),
               Text(
                ".",
                style: TextStyle(
                  color: Colors.grey[400],
                  ),
                ),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[400],
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
