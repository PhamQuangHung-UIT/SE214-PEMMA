import 'package:budget_buddy/presenters/reinput_password_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReinputPasswordView extends StatefulWidget {
  const ReinputPasswordView({super.key});

  @override
  State<ReinputPasswordView> createState() => _ReinputPasswordViewState();
}

class _ReinputPasswordViewState extends State<ReinputPasswordView>
    implements ReinputPasswordViewContract {
  var passwordController = TextEditingController();
  String? passwordErrorText;
  late ReinputPasswordPresenter _presenter;

  var isPasswordHiding = true;

  @override
  void initState() {
    super.initState();
    _presenter = ReinputPasswordPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 50.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/arrow.png',
                  height: 23.adaptSize,
                  width: 23.adaptSize,
                ),
                SizedBox(height: 52.v),
                Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Text(
                    AppLocalizations.of(context)!.reinput_password_title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                SizedBox(height: 10.v),
                Container(
                  width: 292.h,
                  margin: EdgeInsets.only(
                    left: 5.h,
                    right: 32.h,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.reinput_password_body,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 28.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.h,
                    right: 16.h,
                  ),
                  child: CustomTextFormField(
                    controller: passwordController,
                    errorText: passwordErrorText,
                    hintText: AppLocalizations.of(context)!.password,
                    suffix: Container(
                      margin: EdgeInsets.fromLTRB(30.h, 11.v, 16.h, 9.v),
                      child: InkWell(
                        onTap: _changeHidePasswordState,
                        child: Image.asset(
                          isPasswordHiding
                              ? 'assets/images/view.png'
                              : 'assets/images/hide.png',
                          height: 25.adaptSize,
                          width: 25.adaptSize,
                        ),
                      ),
                    ),
                    suffixConstraints: BoxConstraints(maxHeight: 45.v),
                    obscureText: isPasswordHiding,
                  ),
                ),
                SizedBox(height: 42.v),
                CustomElevatedButton(
                  text: AppLocalizations.of(context)!.continue_uppercase,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    right: 17.h,
                  ),
                  onPressed: login,
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
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
    _presenter.login(passwordController.text);
  }

  @override
  void onLoginError(FirebaseException e) {
    Navigator.of(context, rootNavigator: true).pop();
    switch (e.code) {
      case 'wrong-password':
        setState(() {
          passwordErrorText =
              AppLocalizations.of(context)!.email_or_password_incorrect;
        });
        break;
      case 'network-request-failed':
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.network_issue_msg)));
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocalizations.of(context)!.unexpected_error_msg(e.code))));
        break;
    }
  }

  @override
  void onLoginSuccess(UserCredential credential) {
    Navigator.of(context, rootNavigator: true)
      ..pop()
      ..pop(credential);
  }

  void _changeHidePasswordState() => setState(() {
        isPasswordHiding = !isPasswordHiding;
      });
}
