import 'package:budget_buddy/presenters/login_presenter.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_text_form_field.dart';
import 'package:budget_buddy/views/input_email_view.dart';
import 'package:budget_buddy/views/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  static const name = '/login';

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
    emailController.addListener(onEmailFieldChange);
    passwordController.addListener(onPasswordFieldChange);
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
          child: Center(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
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
                                  style: AppTheme
                                      .lightTheme.textTheme.headlineMedium!
                                      .copyWith(fontSize: 36.fSize),
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
                          contentPadding: EdgeInsets.only(
                              left: 15.h, top: 14.v, bottom: 14.v),
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          onTap: () => _emailFocus.requestFocus(),
                        ),
                        SizedBox(height: 36.v),
                        CustomTextFormField(
                          controller: passwordController,
                          focusNode: _passwordFocus,
                          errorText: passwordErrorText,
                          hintText: AppLocalizations.of(context)!.password,
                          suffix: Container(
                            margin:
                                EdgeInsets.fromLTRB(30.h, 11.v, 16.h, 9.v),
                            child: InkWell(
                              onTap: _changeHidePasswordState,
                              child: Image.asset(
                                isPasswordHiding
                                    ? 'assets/images/hide.png'
                                    : 'assets/images/view.png',
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
                              style: AppTheme.lightTheme.textTheme.labelLarge!
                                  .copyWith(color: AppTheme.green800),
                            ),
                          ),
                        ),

                        //Login button
                        CustomElevatedButton(
                            text: AppLocalizations.of(context)!
                                .login
                                .toUpperCase(),
                            onPressed: _onPressLoginBtn),

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
                                style: AppTheme
                                    .lightTheme.textTheme.titleMedium!
                                    .copyWith(color: AppTheme.grey400),
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
                        SizedBox(height: 32.v),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.h),
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
                                      border:
                                          Border.all(color: AppTheme.grey400),
                                      borderRadius:
                                          BorderRadius.circular(15.h)),
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
                                      border:
                                          Border.all(color: AppTheme.grey400),
                                      borderRadius:
                                          BorderRadius.circular(15.h)),
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
                                  text: AppLocalizations.of(context)!
                                      .dont_have_an_account,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelLarge!
                                      .copyWith(color: Colors.black)),
                              const TextSpan(text: ' '),
                              TextSpan(
                                  text: AppLocalizations.of(context)!.sign_up,
                                  style: AppTheme
                                      .lightTheme.textTheme.labelLarge!
                                      .copyWith(color: AppTheme.green800),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = goToSignUpView),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressLoginBtn() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Container(
            width: 100.adaptSize,
            height: 100.adaptSize,
            padding: EdgeInsets.all(16.h),
            color: Colors.white,
            child: const CircularProgressIndicator(color: AppTheme.green800)),
      ),
    );
    _presenter!
        .loginWithPassword(emailController.text, passwordController.text);
  }

  void _onPressGoogleLoginBtn() => _presenter!.loginWithGoogle();

  void _onPressFacebookLoginBtn() => _presenter!.loginWithFacebook();

  void _onPressForgotPasswordButton() => context.push(InputEmailView.name);

  @override
  void onLoginError(FirebaseException e) {
    Navigator.of(context).pop();
    switch (e.code) {
      case 'user-disabled':
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocalizations.of(context)!.unexpected_error_msg(e.code))));
        break;
      case 'network-request-failed':
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.network_issue_msg)));
      default:
        setState(() {
          emailErrorText =
              AppLocalizations.of(context)!.email_or_password_incorrect;
        });
        break;
    }
  }

  void goToSignUpView() {
    context.pushReplacement(SignUpView.name);
  }

  @override
  void onLoginSuccess() {
    context.go('/');
  }

  @override
  void onGetFirstRun(bool firstRun) {
    setState(() {
      this.firstRun = firstRun;
    });
  }

  void onEmailFieldChange() => setState(() {
      emailErrorText = null;
    });

  void onPasswordFieldChange() => setState(() {
      passwordErrorText = null;
    });
}
