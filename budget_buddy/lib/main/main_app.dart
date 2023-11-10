import 'package:budget_buddy/home/home_view.dart';
import 'package:budget_buddy/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// The initial widget for theme, configuration and more
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null) {
                //Chưa đăng nhập
                return const LoginView();
              } else {
                // Đã đăng nhập, vào màn hình chính
                return const HomeView();
              }
            } else {
              // Lỗi mạng
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
