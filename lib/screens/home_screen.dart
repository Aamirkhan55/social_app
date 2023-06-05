import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/post_message.dart';
import 'package:social_app/components/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void postMessage() async{
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('User Post').add({
        'User Email' : currentUser.email,
        'Message' : textController.text,
        'TimeStamp' : DateTime.now(),
        'Likes' : [],
      });
    } 

    setState(() {
      textController.clear();
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Social App'),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          // the wall
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('User Post')
                      .orderBy('TimeStamp', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return PostMessage(
                          message: post['Message'],
                          user: post['userEmail'], 
                          postId: post.id, 
                          likes: List<String>.from(post['Likes'] ?? []),

                        );
                      });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error :${snapshot.error}'),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
          //post message
          Row(
            children: [
              Expanded(
                  child: MyTextField(
                controller: textController,
                hintText: 'Please write Something',
                obsecureText: false,
              ))
            ],
          ),
          // post button
          IconButton(
              onPressed: postMessage, icon: const Icon(Icons.arrow_circle_up)),
          //logged as in
          Text(
            "Logged as in : ${currentUser.email}",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
