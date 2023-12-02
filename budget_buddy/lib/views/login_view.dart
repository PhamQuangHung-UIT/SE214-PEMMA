import 'package:budget_buddy/presenters/login_presenter.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_text_form_field.dart';
import 'package:budget_buddy/views/main_navigation_view.dart';
import 'package:budget_buddy/views/sign_up_view.dart';
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

  final _emailFocus = FocusNode();

  final _passwordFocus = FocusNode();

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
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 39.h,
              vertical: 30.v,
            ),
            child: Column(
              children: [
                SizedBox(height: 43.v),
                SizedBox(
                  height: 235.v,
                  width: 249.h,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          AppLocalizations.of(context)!.login_title,
                          style: AppTheme.lightTheme.textTheme.headlineMedium!.copyWith(fontSize: 36.fSize),
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
                CustomTextFormField(
                  controller: emailController,
                  focusNode: _emailFocus,
                  hintText: 'Email',
                  errorText: emailErrorText,
                  contentPadding: EdgeInsets.only(left: 15.h, top: 14.v, bottom: 14.v),
                  textInputType: TextInputType.emailAddress,
                  validator: emailInputValidator,
                  onTap: () => _emailFocus.requestFocus(),
                ),
                SizedBox(height: 36.v),
                CustomTextFormField(
                  controller: passwordController,
                  focusNode: _passwordFocus,
                  errorText: passwordErrorText,
                  hintText: AppLocalizations.of(context)!.password,
                  suffix: Container(
                    margin: EdgeInsets.fromLTRB(30.h, 11.v, 16.h, 9.v),
                    child: InkWell(
                      onTap: _changeHidePasswordState,
                      child: Image.asset(
                        isPasswordHiding ? 'assets/images/hide.png' : 'assets/images/view.png',
                        height: 25.adaptSize,
                        width: 25.adaptSize,
                      ),
                    ),
                  ),
                  suffixConstraints: BoxConstraints(maxHeight: 45.v),
                  contentPadding: EdgeInsets.only(
                    left: 15.h,
                    top: 14.v,
                    bottom: 14.v,
                  ),
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: isPasswordHiding,
                  onTap: () => _passwordFocus.requestFocus(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _onPressForgotPasswordButton,
                    child: Text(
                      AppLocalizations.of(context)!.forgot_password,
                      style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(color: AppTheme.green800),
                    ),
                  ),
                ),

                //Login button
                CustomElevatedButton(text: AppLocalizations.of(context)!.login_uppercase, onPressed: _onPressLoginBtn),

                SizedBox(height: 34.v),
                Row(
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
                      padding: EdgeInsets.only(left: 9.h, right: 9.h),
                      child: Text(
                        AppLocalizations.of(context)!.or,
                        style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(color: AppTheme.grey400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 9.v),
                      child: SizedBox(
                        width: 95.h,
                        child: const Divider(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 37.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 43.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: _onPressFacebookLoginBtn,
                        child: Container(
                          height: 65.v,
                          width: 80.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.h,
                            vertical: 12.v,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.grey400), borderRadius: BorderRadius.circular(15.h)),
                          child: Image.asset(
                            'assets/images/facebook.png',
                            height: 35.adaptSize,
                            width: 35.adaptSize,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 26.v),
                      InkWell(
                        onTap: _onPressGoogleLoginBtn,
                        child: Container(
                          height: 65.v,
                          width: 80.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.h,
                            vertical: 12.v,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.grey400), borderRadius: BorderRadius.circular(15.h)),
                          child: Image.asset(
                            'assets/images/gmail.png',
                            height: 35.adaptSize,
                            width: 35.adaptSize,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 37.v),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: AppLocalizations.of(context)!.dont_have_an_account,
                          style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(color: Colors.black)),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: AppLocalizations.of(context)!.sign_up,
                        style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(color: AppTheme.green800),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressLoginBtn() => _presenter!.loginWithPassword(emailController.text, passwordController.text);

  void _onPressGoogleLoginBtn() => _presenter!.loginWithGoogle();

  void _onPressFacebookLoginBtn() => _presenter!.loginWithFacebook();

  void _onPressForgotPasswordButton() {}

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
                    CustomElevatedButton(
                      width: 80.h,
                      text: AppLocalizations.of(context)!.sign_up,
                      onPressed: () {
                        // Pop the dialog and navigate to Sign up view
                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (context) => const SignUpView()));
                      },
                    ),
                    // Cancel button
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(AppLocalizations.of(context)!.cancel_btn))
                  ],
                ));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unexpected error. Code: ${e.code}')));
        break;
    }
  }

  @override
  void onLoginSuccess() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainNavigationView()));
  }

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
