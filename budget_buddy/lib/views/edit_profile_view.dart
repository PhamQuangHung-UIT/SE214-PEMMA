import 'package:budget_buddy/presenters/edit_profile_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/utils/firebase_options.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_text_form_field.dart';
import 'package:budget_buddy/views/auth_view.dart';
import 'package:budget_buddy/views/reinput_password_view.dart';
import 'package:budget_buddy/views/send_verification_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileView extends StatefulWidget {
  final String fullname;

  final String email;

  const EditProfileView(this.fullname, this.email, {Key? key})
      : super(
          key: key,
        );

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView>
    implements EditProfileViewContract {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  late EditProfilePresenter _presenter;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.fullname;
    emailController.text = widget.email;
    _presenter = EditProfilePresenter(this);
    _presenter.oldEmail = widget.email;
    _presenter.oldFullname = widget.fullname;
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80.v,
          backgroundColor: Colors.transparent,
          leadingWidth: 60.h,
          leading: Padding(
            padding: EdgeInsets.only(
              left: 20.h,
              top: 14.v,
              bottom: 18.v,
            ),
            child: InkWell(
              onTap: Navigator.of(context, rootNavigator: true).pop,
              borderRadius: BorderRadius.circular(15.h),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('assets/images/arrow.png',
                    width: 23.adaptSize, height: 23.adaptSize),
              ),
            ),
          ),
          title: Text(AppLocalizations.of(context)!.profile_navigation_bar,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w700)),
          titleSpacing: 0,
          centerTitle: true,
        ),
        body: Form(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 17.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.full_name}:',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12.v),
                Padding(
                  padding: EdgeInsets.only(right: 21.h),
                  child: CustomTextFormField(
                    controller: nameController,
                    hintText: AppLocalizations.of(context)!.full_name,
                  ),
                ),
                SizedBox(height: 16.v),
                Text(
                  "Email:",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 13.v),
                Padding(
                  padding: EdgeInsets.only(right: 21.h),
                  child: CustomTextFormField(
                    controller: emailController,
                    hintText: "Email",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: 32.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 21.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: Navigator.of(context, rootNavigator: true).pop,
                          child: Container(
                            height: 45.v,
                            width: 82.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.h,
                              vertical: 11.v,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.grey400,
                              borderRadius: BorderRadius.circular(15.h),
                            ),
                            child: Image.asset('assets/images/close.png',
                                height: 22.adaptSize, width: 22.adaptSize),
                          ),
                        ),
                        InkWell(
                          onTap: sendUserInfo,
                          child: Container(
                            height: 45.v,
                            width: 82.h,
                            margin: EdgeInsets.only(left: 20.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 26.h,
                              vertical: 7.v,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.green800,
                              borderRadius: BorderRadius.circular(15.h),
                            ),
                            child: Image.asset('assets/images/check.png',
                                height: 30.adaptSize, width: 30.adaptSize),
                          ),
                        ),
                      ],
                    ),
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

  void sendUserInfo() {
    if (nameController.text == widget.fullname &&
        emailController.text == widget.email) return;

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
    var continueUrl =
        Uri.https(DefaultFirebaseOptions.web.authDomain!, '/profile');
    _presenter.updateUserData(
        nameController.text, emailController.text, continueUrl.toString());
  }

  void sendVerificationToUser() {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) => SendVerificationEmailView(
            authType: AuthType.changeEmail, email: emailController.text)));
  }

  @override
  void onUpdateComplete() {
    Navigator.of(context, rootNavigator: true)
      ..pop()
      ..pop();
  }

  @override
  void onUpdateError(FirebaseException e) {
    Navigator.of(context, rootNavigator: true).pop();
    switch (e.code) {
      case 'network-request-failed':
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.network_issue_msg)));
        break;
      case 'requires-recent-login':
        Navigator.of(context, rootNavigator: true)
            .push<UserCredential>(
                MaterialPageRoute(builder: (_) => const ReinputPasswordView()))
            .then((value) {
          if (value == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocalizations.of(context)!
                    .unexpected_error_msg('login-fail'))));
          } else {
            sendVerificationToUser();
          }
        });
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocalizations.of(context)!.unexpected_error_msg(e.code))));
    }
  }
}
