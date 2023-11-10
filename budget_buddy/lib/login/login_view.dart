import 'package:budget_buddy/login/landing_view.dart';
import 'package:budget_buddy/login/login_controller.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  static LoginController controller = LoginController();

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.isFirstTime(),
        builder: (context, snapshot) {
          bool isFirstTime = snapshot.data ?? true;
          if (isFirstTime) {
						// Change first time state to false
            //controller.removeFirstTimeState();
						
						// Navigate to landing view
            Navigator.of(context).push(MaterialPageRoute(
							builder: (context) => const LandingView() 
						));
          }
          return Padding(
            padding: const EdgeInsets.all(41.0),
            child: Column(
              children: [

								// Title
                const Center(
                  child: Text("Welcome, buddy!", style: TextStyle(fontFamily: "Montserrat", fontSize: 28)),
                ),

								// App logo
                Center(child: Image.asset('assets/images/logo.png', width: 200, height: 200)),

								// Username Text Field
                Padding(
                  padding: const EdgeInsets.only(top: 38),
                  child: Material(
                      child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              ),
                              errorText: 'Email or password was incorrect',
                              errorStyle: TextStyle(color: Colors.red)),
                          onSubmitted: (value) {
                            controller.username = value;
                          })),
                ),

								// Password Text Field
                Padding(
                  padding: const EdgeInsets.only(top: 38),
                  child: Material(
                    child: TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                            errorText: 'Email or password was incorrect',
                            errorStyle: TextStyle(color: Colors.red)),
                        onSubmitted: (value) {
                          controller.password = value;
                        }),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
