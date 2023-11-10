import 'package:budget_buddy/login/login_view.dart';
import 'package:flutter/material.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [

        // Logo
        Image.asset(
          'assets/images/logo.png',
          width: 200,
          height: 200,
        ),

        // Title
        const Text(
          'Welcome to Budget Buddy!',
          style: TextStyle(fontSize: 28),
        ),

        // Button
        Padding(
          padding: const EdgeInsets.only(top: 142),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginView()
                  )
                );
              },
              child: const Text('Get started')),
        ),
      ]),
    );
  }
}
