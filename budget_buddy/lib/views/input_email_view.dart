import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController passwordController = TextEditingController();

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
                    "Forgot Password",
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
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppTheme.green800),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: AppLocalizations.of(context)!.to_reset_your_password,
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
                    controller: passwordController,
                    hintText: "Email",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 42.v),
                CustomElevatedButton(
                  text: "CONTINUE",
                  margin: EdgeInsets.only(
                    left: 4.h,
                    right: 17.h,
                  ),
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
