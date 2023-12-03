import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class SendEmailVerificationView extends StatelessWidget {
  const SendEmailVerificationView({key}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 39.h,
            top: 137.v,
            right: 39.h,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 200.adaptSize,
                width: 200.adaptSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 200.adaptSize,
                      width: 200.adaptSize,
                      alignment: Alignment.center,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 200.adaptSize,
                      width: 200.adaptSize,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.v),
              Text(
                "Email sent!",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 13.v),
              Container(
                width: 285.h,
                margin: EdgeInsets.symmetric(horizontal: 13.h),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.email_vertification_msg_1,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: AppLocalizations.of(context)!.your_inbox,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppTheme.green800),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text:  AppLocalizations.of(context)!.email_vertification_msg_2,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppTheme.green800)
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 25.v),
              CustomElevatedButton(
                text: AppLocalizations.of(context)!.resend_uppercase,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}
