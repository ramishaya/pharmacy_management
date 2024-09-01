
import 'package:flutter/material.dart';
import 'package:pharmacy/Features/Login/presentation/views/widgets/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBody()
    );
  }
}
//shared_preferences: ^2.0.16 
