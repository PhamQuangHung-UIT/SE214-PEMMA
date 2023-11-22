import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/view/login_view.dart';
import 'package:flutter/material.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 158.v, horizontal: 54.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/logo.png',
              alignment: Alignment.bottomCenter,
              height: 200,
            ),
          
            // Title
            Text(
              AppLocalizations.of(context)!.welcome_title,
              style: AppTheme.lightTheme.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            //Space
            const Spacer(),
            // Button
            CustomElevatedButton(
              height: 58.v,
              text: AppLocalizations.of(context)!.get_started,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LoginView())),
            ),
          ]),
      ),
    );
  }
}
