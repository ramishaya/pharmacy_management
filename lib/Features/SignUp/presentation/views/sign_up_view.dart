import 'package:flutter/material.dart';

import 'package:pharmacy/Features/SignUp/presentation/views/widgets/sign_up_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignUpBody());
  }
}
