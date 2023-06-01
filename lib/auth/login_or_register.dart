import 'package:flutter/material.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/screens/register_screen.dart';

class LogInOrRegister extends StatefulWidget {
  const LogInOrRegister({super.key});

  @override
  State<LogInOrRegister> createState() => _LogInOrRegisterState();
}

class _LogInOrRegisterState extends State<LogInOrRegister> {

// Initial LogIn
bool showLogInPage = true;

// Toggle Pages
void togglePages() {
  setState(() {
    showLogInPage = !showLogInPage;
  });
}

  @override
  Widget build(BuildContext context) {
   if (showLogInPage) {
     return LogInScreen(onTap: togglePages);
   } else {
     return RegisterScreen(onTap: togglePages);
   }
  }
}