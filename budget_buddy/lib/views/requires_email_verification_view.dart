import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/views/auth_view.dart';
import 'package:budget_buddy/views/login_view.dart';
import 'package:budget_buddy/views/send_verification_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequireEmailVerificationView extends StatefulWidget {
  static String name = '/requireEmailVerify';

  final User user;

  const RequireEmailVerificationView(this.user, {super.key});

  @override
  State<RequireEmailVerificationView> createState() =>
      _RequireEmailVerificationViewState();
}

class _RequireEmailVerificationViewState
    extends State<RequireEmailVerificationView> {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        goToLogin();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 50.v),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: goToLogin,
                      child: Image.asset(
                        'assets/images/arrow.png',
                        height: 23.adaptSize,
                        width: 23.adaptSize,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 52.v),
                Image.asset(
                  'assets/images/logo.png',
                  height: 200.adaptSize,
                  width: 200.adaptSize,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 5.v),
                Text(
                  AppLocalizations.of(context)!
                      .required_email_verification_title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.v),
                SizedBox(
                  height: 250.v,
                  child: Text(
                    AppLocalizations.of(context)!
                        .required_email_verification_body,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40.h),
                CustomElevatedButton(
                  text: AppLocalizations.of(context)!.resend_uppercase,
                  onPressed: _continue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _continue() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SendVerificationEmailView(
            authType: AuthType.signUp, user: widget.user)));
  }

  void goToLogin() {
    context.go(LoginView.name);
  }
}
