import 'package:budget_buddy/presenters/input_email_presenter.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_text_form_field.dart';
import 'package:budget_buddy/views/auth_view.dart';
import 'package:budget_buddy/views/send_verification_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class InputEmailView extends StatefulWidget {
  static const name = '/inputEmail';

  final String? email;

  const InputEmailView({Key? key, this.email})
      : super(
          key: key,
        );

  @override
  State<InputEmailView> createState() => _InputEmailViewState();
}

class _InputEmailViewState extends State<InputEmailView>
    implements InputEmailViewContract {
  late TextEditingController emailController;

  late InputEmailPresenter _presenter;

  String? emailErrorText;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
    _presenter = InputEmailPresenter(this);
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
                    AppLocalizations.of(context)!.reset_password,
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
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.please_enter,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: AppLocalizations.of(context)!.your_email,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppTheme.green800),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: AppLocalizations.of(context)!
                              .to_reset_your_password,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
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
                    controller: emailController,
                    hintText: "Email",
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: 42.v),
                CustomElevatedButton(
                  text: AppLocalizations.of(context)!.continue_uppercase,
                  margin: EdgeInsets.only(
                    left: 4.h,
                    right: 17.h,
                  ),
                  onPressed: onContinue,
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onContinue() => _presenter.checkEmailExisted(emailController.text);

  @override
  void onCheckEmailExistedSuccess(String email) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => SendVerificationEmailView(
              authType: AuthType.resetPassword, email: emailController.text)));
  @override
  void onCheckEmailExistedFailed(FirebaseAuthException e) {
    setState(() {
      emailErrorText = "Invalid email";
    });
  }
}
