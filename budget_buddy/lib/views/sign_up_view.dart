import 'package:budget_buddy/presenters/sign_up_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_text_form_field.dart';
import 'package:budget_buddy/views/auth_view.dart';
import 'package:budget_buddy/views/login_view.dart';
import 'package:budget_buddy/views/send_verification_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatefulWidget {
  static const name = '/sign_up';

  const SignUpView({Key? key})
      : super(
          key: key,
        );

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> implements SignUpViewContract {
  final fullNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final fullNameFocus = FocusNode();
  
  final emailFocus = FocusNode();

  final passwordFocus = FocusNode();

  final confirmPasswordFocus = FocusNode();

  String? fullNameError, emailError, passwordError, confirmPasswordError;

  bool isPasswordHiding = true;

  late SignUpPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = SignUpPresenter(this);
    fullNameController.addListener(fullNameListener);
    emailController.addListener(emailListener);
    passwordController.addListener(passwordListener);
    confirmPasswordController.addListener(confirmPasswordListener);
  }

  void changePasswordHidingState() {
    setState(() {
      isPasswordHiding = !isPasswordHiding;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxWidth),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 22.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SizedBox(width: 22.h),
                        Image.asset(
                          'assets/images/arrow.png',
                          height: 23.adaptSize,
                          width: 23.adaptSize,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 30.h, right: 30.h, top: 50.v, bottom: 6.v),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 250.h,
                                  child: Text(
                                    AppLocalizations.of(context)!.sign_up_title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ),
                              ),
                              SizedBox(height: 42.v),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.h),
                                child: CustomTextFormField(
                                  controller: fullNameController,
                                  hintText:
                                      AppLocalizations.of(context)!.full_name,
                                    errorText: fullNameError,
                                    focusNode: fullNameFocus,
                                    onTap: fullNameFocus.requestFocus,
                                ),
                              ),
                              SizedBox(height: 32.v),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.h),
                                child: CustomTextFormField(
                                  controller: emailController,
                                  hintText: AppLocalizations.of(context)!.email,
                                  textInputType: TextInputType.emailAddress,
                                  errorText: emailError,
                                  focusNode: emailFocus,
                                  onTap: emailFocus.requestFocus,
                                ),
                              ),
                              SizedBox(height: 32.v),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.h),
                                child: CustomTextFormField(
                                  controller: passwordController,
                                  hintText:
                                      AppLocalizations.of(context)!.password,
                                  errorText: passwordError,
                                  focusNode: passwordFocus,
                                  onTap: passwordFocus.requestFocus,
                                  textInputType: TextInputType.visiblePassword,
                                  suffix: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        30.h, 11.v, 16.h, 9.v),
                                    child: InkWell(
                                      onTap: changePasswordHidingState,
                                      child: Image.asset(
                                        isPasswordHiding
                                            ? 'assets/images/hide.png'
                                            : 'assets/images/view.png',
                                        height: 25.adaptSize,
                                        width: 25.adaptSize,
                                      ),
                                    ),
                                  ),
                                  suffixConstraints: BoxConstraints(
                                    maxHeight: 45.v,
                                  ),
                                  obscureText: isPasswordHiding,
                                  contentPadding: EdgeInsets.only(
                                    left: 18.h,
                                    top: 14.v,
                                    bottom: 14.v,
                                  ),
                                ),
                              ),
                              SizedBox(height: 32.v),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.h),
                                child: CustomTextFormField(
                                  controller: confirmPasswordController,
                                  hintText: AppLocalizations.of(context)!
                                      .confirm_password,
                                  errorText: confirmPasswordError,
                                  focusNode: confirmPasswordFocus,
                                  onTap: confirmPasswordFocus.requestFocus,
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  contentPadding: EdgeInsets.only(
                                    left: 18.h,
                                    top: 14.v,
                                    bottom: 14.v,
                                  ),
                                ),
                              ),
                              SizedBox(height: 45.v),
                              // Sign up button
                              CustomElevatedButton(
                                text: AppLocalizations.of(context)!
                                    .sign_up
                                    .toUpperCase(),
                                margin: EdgeInsets.only(
                                  left: 6.h,
                                  right: 6.h,
                                ),
                                onPressed: signUp,
                              ),
                              SizedBox(height: 40.v),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 9.v),
                                      child: SizedBox(
                                        width: 95.h,
                                        child: const Divider(),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 12.h, right: 12.h),
                                      child: Text(
                                        AppLocalizations.of(context)!.or,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: AppTheme.grey400),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 9.v),
                                      child: SizedBox(
                                        width: 95.h,
                                        child: const Divider(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 37.v),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 43.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
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
                                            BorderRadius.circular(15.h),
                                      ),
                                      child: Image.asset(
                                        'assets/images/facebook.png',
                                        height: 35.adaptSize,
                                        width: 35.adaptSize,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    SizedBox(width: 26.h),
                                    Container(
                                      height: 65.v,
                                      width: 80.h,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 25.h,
                                        vertical: 12.v,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppTheme.grey400),
                                          borderRadius:
                                              BorderRadius.circular(15.h)),
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
                              SizedBox(height: 37.v),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .already_have_an_account,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                    const TextSpan(text: ' '),
                                    TextSpan(
                                        text:
                                            AppLocalizations.of(context)!.login,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: AppTheme.green800),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = goToLoginView),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 45.v),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToLoginView() => context.push(LoginView.name);

  void signUp() {
    var fullname = fullNameController.text;
    var email = emailController.text;
    var password = passwordController.text;
    var confirmPassword = confirmPasswordController.text;

    _presenter.signUp(fullname, email, password, confirmPassword);
  }

  @override
  void onCreateSignUpInfoFailed(FirebaseAuthException e) {
    switch (e.code) {
      case 'empty-fullname':
        setState(() {
          fullNameError = AppLocalizations.of(context)!.empty_fullname_msg;
        });
        break;
      case 'invalid-email':
        setState(() {
          emailError = AppLocalizations.of(context)!.invalid_email;
        });
        break;
      case 'password-6-characters':
        setState(() {
          passwordError =
              AppLocalizations.of(context)!.password_6_characters_msg;
        });
        break;
      case 'password-not-match':
        setState(() {
          confirmPasswordError =
              AppLocalizations.of(context)!.password_not_match_msg;
        });
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocalizations.of(context)!.unexpected_error_msg(e.code),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white))));
        break;
    }
  }

  @override
  void onCreateSignUpInfoSuccess() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SendVerificationEmailView(
              authType: AuthType.signUp,
              email: emailController.text,
            )));
  }

  void fullNameListener() => setState(() => fullNameError = null);

  void emailListener() => setState(() => emailError = null);

  void passwordListener() => setState(() => passwordError = null);

  void confirmPasswordListener() => setState(() => confirmPasswordError = null);
}
