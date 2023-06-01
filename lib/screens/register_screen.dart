import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/button.dart';
import 'package:social_app/components/text_field.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final canfirmPasswordController = TextEditingController();

  void create() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordTextController.text != canfirmPasswordController.text) {
      Navigator.pop(context);
      displayMessage("Password don't match!");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
                "Lets create an account for you !",
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
              MyTextField(
                controller: canfirmPasswordController,
                hintText: 'Canfirm Password',
                obsecureText: true,
              ),
              const SizedBox(height: 10),
              // Register
              MyButton(
                text: 'Register',
                onTap: create,
              ),
              const SizedBox(height: 25),
              // Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'LogIn Now',
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
