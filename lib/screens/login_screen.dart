import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/button.dart';
import 'package:social_app/components/text_field.dart';

class LogInScreen extends StatefulWidget {
  final Function()? onTap;
  const LogInScreen({super.key, this.onTap});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if(context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
       Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              // Welcome notes
              const SizedBox(height: 50),
              Text(
                "WellCome Back You've been messed !",
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 25),
              // Email
              MyTextField(
                controller: emailTextController,
                hintText: 'Email',
                obsecureText: false,
              ),
              const SizedBox(height: 10),
              // Password
              MyTextField(
                controller: passwordTextController,
                hintText: 'Password',
                obsecureText: true,
              ),
              const SizedBox(height: 10),
              // Log in
              MyButton(
                text: 'Log In',
                onTap: signIn,
              ),
              const SizedBox(height: 25),
              // Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
