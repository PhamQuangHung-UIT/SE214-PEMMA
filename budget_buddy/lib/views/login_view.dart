import 'package:budget_buddy/presenters/login_presenter.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements LoginViewContract {
  LoginPresenter? _presenter;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  var isPasswordHiding = true;

  bool firstRun = false;

  String? emailErrorText;

  String? passwordErrorText;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this);
  }

  void _changeHidePasswordState() {
    setState(() {
      isPasswordHiding = !isPasswordHiding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 39.h,
            vertical: 40.v,
          ),
          child: Column(
            children: [
              SizedBox(height: 43.v),
              SizedBox(
                height: 229.v,
                width: 249.h,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Welcome, buddy!",
                        style: AppTheme.lightTheme.textTheme.headlineMedium,
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 200.adaptSize,
                      width: 200.adaptSize,
                      alignment: Alignment.bottomCenter,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 38.v),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: emailErrorText,
                    contentPadding: EdgeInsets.only(left: 15.h, top: 14.v, bottom: 14.v)),
                keyboardType: TextInputType.emailAddress,
                validator: emailInputValidator,
              ),
              SizedBox(height: 36.v),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    errorText: passwordErrorText,
                    hintText: AppLocalizations.of(context)!.password,
                    suffixIcon: Container(
                      margin: EdgeInsets.fromLTRB(30.h, 11.v, 16.h, 9.v),
                      child: InkWell(
                        onTap: _changeHidePasswordState,
                        child: Image.asset(
                          'assets/images/hide.png',
                          height: 25.adaptSize,
                          width: 25.adaptSize,
                        ),
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(maxHeight: 45.v),
                    contentPadding: EdgeInsets.only(
                      left: 15.h,
                      top: 14.v,
                      bottom: 14.v,
                    )),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(height: 8.v),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password?",
                  style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(color: AppTheme.green800),
                ),
              ),
              SizedBox(height: 26.v),

              //Login button
              CustomElevatedButton(
                text: AppLocalizations.of(context)!.login_uppercase, 
                onPressed: () => _presenter!.loginWithPassword(emailController.text, passwordController.text)),

              SizedBox(height: 34.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 9.v),
                      child: SizedBox(
                        width: 95.h,
                        child: const Divider(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h, right: 10.h),
                      child: Text(
                        "or",
                        style: AppTheme.lightTheme.textTheme.titleMedium,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.v,
                        bottom: 8.v,
                      ),
                      child: SizedBox(
                        width: 95.h,
                        child: const Divider(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 43.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 61.v,
                      width: 88.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.h,
                        vertical: 12.v,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.white70,
                        width: 1.h,
                      )),
                      child: Image.asset(
                        'assets/images/facebook.png',
                        height: 35.adaptSize,
                        width: 35.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                    Container(
                      height: 61.v,
                      width: 88.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.h,
                        vertical: 12.v,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70, width: 1.h),
                          borderRadius: BorderRadius.circular(15.h)),
                      child: Image.asset(
                        'assets/images/gmail.png',
                        height: 35.adaptSize,
                        width: 35.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don’t have an account? ",
                      style: AppTheme.lightTheme.textTheme.labelLarge!
                          .copyWith(color: AppTheme.lightTheme.colorScheme.primaryContainer),
                    ),
                    TextSpan(
                      text: "Sign up",
                      style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(color: const Color(0xFF03A700)),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onLoginError(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
        setState(() {
          emailErrorText = AppLocalizations.of(context)!.email_or_password_incorrect;
        });
        break;
      case 'user-not-found':
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text(AppLocalizations.of(context)!.user_not_found_dialog_msg),
                  actions: [
                    CustomElevatedButton(text: AppLocalizations.of(context)!.sign_up),
                    // Cancel button
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(AppLocalizations.of(context)!.cancel_btn))
                  ],
                ));
        break;
      default:

        break;
    }
  }

  @override
  void onLoginSuccess() {}

  @override
  void onGetFirstRun(bool firstRun) {
    setState(() {
      this.firstRun = firstRun;
    });
  }

  String? emailInputValidator(String? input) {
    if (input == null) {
      return AppLocalizations.of(context)!.email_empty_message;
    }
    return EmailValidator.validate(input) ? null : AppLocalizations.of(context)!.invalid_email;
  }
}
