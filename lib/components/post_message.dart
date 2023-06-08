import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/comment_button.dart';
import 'package:social_app/components/like_button.dart';

class PostMessage extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  const PostMessage({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
  });

  @override
  State<PostMessage> createState() => _PostMessageState();
}

class _PostMessageState extends State<PostMessage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _commentTextController = TextEditingController();
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Post")
        .doc(widget.postId)
        .collection('Comments')
        .add({
      "CommentText": commentText,
      "CommentBy": currentUser.email,
      "CommentTime": Timestamp.now(),
    });
  }

  void showCommentDailog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add Comment"),
              content: TextField(
                controller: _commentTextController,
                decoration:
                    const InputDecoration(helperText: 'Write Comment ..'),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _commentTextController.clear();
                  },
                  child: const Text('Cancle'),
                ),
                TextButton(
                    onPressed: () {
                      addComment(_commentTextController.text);
                      Navigator.pop(context);
                      _commentTextController.clear();
                    },
                    child: const Text('Post')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 10),
              Text(widget.message),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  //Like Button
                  LikedButton(
                    isLiked: true,
                    onTap: toggleLike,
                  ),
                  const SizedBox(height: 10),
                  // Like Count
                  Text(
                    widget.likes.length.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  //Commenty Button
                  CommentButton(
                    onTap: showCommentDailog,
                  ),
                  const SizedBox(height: 10),
                  // Like Count
                  const Text(
                    '0',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
