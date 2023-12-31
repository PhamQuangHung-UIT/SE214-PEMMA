import 'package:budget_buddy/presenters/email_verification_success_presenter.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/views/unexpected_error_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationSuccessView extends StatefulWidget {
  static String name = '/signUpSuccess';

  final String mode;

  final String code;

  final String continueUrl;

  const EmailVerificationSuccessView(this.mode, this.code, this.continueUrl, {Key? key})
      : super(key: key);

  @override
  State<EmailVerificationSuccessView> createState() =>
      _EmailVerificationSuccessViewState();
}

class _EmailVerificationSuccessViewState
    extends State<EmailVerificationSuccessView>
    implements EmailVerificationSuccessViewContract {
  late EmailVerificationSuccessPresenter _presenter;

  String? _email;

  @override
  void initState() {
    super.initState();
    _presenter = EmailVerificationSuccessPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return FutureBuilder(
        future: _presenter.verifyEmail(widget.code),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done ||
              _email == null) {
            return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(color: AppTheme.green800)),
            );
          }
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      left: 39.h,
                      top: 137.v,
                      right: 39.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200.adaptSize,
                          width: 200.adaptSize,
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 200.adaptSize,
                            width: 200.adaptSize,
                            alignment: Alignment.center,
                          ),
                        ),
                        SizedBox(height: 10.v),
                        SizedBox(
                          height: 30.v,
                          child: Text(
                            AppLocalizations.of(context)!
                                .email_verification_success_title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        SizedBox(height: 20.v),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 13.h),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .email_verification_success_body,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextSpan(
                                    text: ' $_email',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: AppTheme.green800))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 120.v),
                        CustomElevatedButton(
                          text: 'OK',
                          onPressed: goToContinueUrl,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void onVerifyFailed(FirebaseException e) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const UnexpectedErrorView())));
  }

  @override
  void onVerifySuccess(String email) {
    _email = email;
  }

  void goToContinueUrl() {
    Uri continueUri = Uri.parse(widget.continueUrl);
    context.go(continueUri.path);
  }
}
