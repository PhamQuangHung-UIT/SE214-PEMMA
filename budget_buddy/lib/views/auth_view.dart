import 'package:budget_buddy/presenters/auth_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/views/create_new_password_view.dart';
import 'package:budget_buddy/views/email_verification_success_view.dart';
import 'package:budget_buddy/views/unexpected_error_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthView extends StatefulWidget {
  static const name = '/auth';

  final String mode;

  final String actionCode;

  final String continueUrl;

  const AuthView(this.mode, this.actionCode, this.continueUrl, {super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late AuthPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = AuthPresenter();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _presenter.handleAuthData(widget.mode, widget.actionCode),
        builder: (context, snapshot) {
          var dataMap = snapshot.data;
          if (dataMap != null && dataMap.isNotEmpty) {
            dataMap.addAll({'continueUrl': widget.continueUrl});
            if (widget.mode == 'resetPassword') {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                  context.replace(Uri(
                          path: CreateNewPasswordView.name,
                          queryParameters: dataMap)
                      .toString()));
            } else if (widget.mode == 'verifyEmail' ||
                widget.mode == 'verifyAndChangeEmail') {
              dataMap.addAll({'mode': widget.mode});
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                  context.replace(Uri(
                          path: EmailVerificationSuccessView.name,
                          queryParameters: dataMap)
                      .toString()));
            }
          } else if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const UnexpectedErrorView())));
          }
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(color: AppTheme.green800)),
          );
        });
  }
}

enum AuthType { signUp, resetPassword, changeEmail }
