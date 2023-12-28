import 'package:budget_buddy/presenters/create_new_password_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordView extends StatefulWidget {
  static const name = '/newPassword';

  final String email;

  final String actionCode;

  const CreateNewPasswordView(this.email, this.actionCode, {super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView>
    implements CreateNewPasswordViewContract {
  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  late CreateNewPasswordPresenter _presenter;

  String? passwordError;

  @override
  void initState() {
    super.initState();
    _presenter = CreateNewPasswordPresenter(this);
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
                    AppLocalizations.of(context)!.create_new_password_title,
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
                    text: TextSpan(children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .create_new_password_msg,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                          text: widget.email,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppTheme.green800))
                    ]),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 28.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.h,
                    right: 16.h,
                    top: 12.v
                  ),
                  child: CustomTextFormField(
                    controller: passwordController,
                    hintText: AppLocalizations.of(context)!.password,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.h,
                    right: 16.h,
                    top: 12.v
                  ),
                  child: CustomTextFormField(
                    controller: confirmPasswordController,
                    hintText: AppLocalizations.of(context)!.confirm_password,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 42.v),
                CustomElevatedButton(
                  text: AppLocalizations.of(context)!.continue_uppercase,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    right: 17.h,
                  ),
                  onPressed: createNewPassword,
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createNewPassword() => _presenter.resetPassword(passwordController.text,
      confirmPasswordController.text, widget.actionCode);

  @override
  void onCreateNewPasswordFalied(FirebaseException e) {
    switch (e.code) {
      case 'password-not-match':
        setState(() {
          passwordError = AppLocalizations.of(context)!.password_not_match_msg;
        });
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            AppLocalizations.of(context)!.unexpected_error_msg(e.code),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ));
        break;
    }
  }

  @override
  void onCreateNewPasswordSuccess() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.v)),
              content: Text(
                  AppLocalizations.of(context)!.create_new_password_success_msg,
                  style: Theme.of(context).textTheme.bodyLarge),
              actions: [
                CustomElevatedButton(
                  width: 70.h,
                  text: 'OK',
                  onPressed: () => context.pop(),
                ),
              ],
            )).then((value) => context.go('/'));
  }
}