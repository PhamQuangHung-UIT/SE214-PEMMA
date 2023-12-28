import 'package:budget_buddy/presenters/profile_presenter.dart';
import 'package:budget_buddy/presenters/send_verification_email_presenter.dart';
import 'package:budget_buddy/resources/utils/firebase_options.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/views/auth_view.dart';
import 'package:budget_buddy/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class SendVerificationEmailView extends StatefulWidget {
  final AuthType authType;

  final String? email;

  const SendVerificationEmailView({key, required this.authType, this.email})
      : super(key: key);

  @override
  State<SendVerificationEmailView> createState() =>
      _SendVerificationEmailViewState();
}

class _SendVerificationEmailViewState extends State<SendVerificationEmailView> {
  final _presenter = SendVerificationEmailPresenter();

  var isDisabled = false;

  late Uri continueUrl;

  @override
  void initState() {
    super.initState();
    continueUrl = Uri.https(DefaultFirebaseOptions.web.authDomain!,
        widget.authType == AuthType.changeEmail ? '/profile' : LoginView.name);

    resend();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 50.v),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/arrow.png',
                    height: 23.adaptSize,
                    width: 23.adaptSize,
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
                AppLocalizations.of(context)!.email_sent,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 25.v),
              Expanded(
                child: Text(
                  widget.authType == AuthType.signUp
                      ? AppLocalizations.of(context)!
                          .email_verification_msg(widget.email!)
                      : widget.authType == AuthType.changeEmail
                          ? AppLocalizations.of(context)!
                              .update_email_verification_msg(widget.email!)
                          : AppLocalizations.of(context)!.reset_password_msg,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 40.h),
              CustomElevatedButton(
                text: AppLocalizations.of(context)!.resend_uppercase,
                isDisabled: isDisabled,
                onPressed: resend,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resend() => switch (widget.authType) {
        AuthType.signUp => _presenter.sendVerificationEmail(
            widget.email!,
            continueUrl.toString(),
            ProfilePresenter().currentLocale.languageCode),
        AuthType.changeEmail => _presenter.sendUpdateEmailVerification(
            widget.email!,
            continueUrl.toString(),
            ProfilePresenter().currentLocale.languageCode),
        _ => _presenter.sendResetPasswordEmail(
            widget.email!,
            continueUrl.toString(),
            ProfilePresenter().currentLocale.languageCode)
      };
}
