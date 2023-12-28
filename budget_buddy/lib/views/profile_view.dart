import 'package:budget_buddy/models/user_model.dart';
import 'package:budget_buddy/presenters/profile_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_elevated_button.dart';
import 'package:budget_buddy/resources/widget/custom_selectable_dialog.dart';
import 'package:budget_buddy/views/edit_profile_view.dart';
import 'package:budget_buddy/views/input_email_view.dart';
import 'package:budget_buddy/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore_for_file: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({Key? key})
      : super(
          key: key,
        );

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    implements ProfileViewContract {
  late User _user;
  var _isLoadingData = true;
  late ProfilePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ProfilePresenter();
    _presenter.profileViewContract = this;
    _presenter.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: _createBodyView(),
      ),
    );
  }

  Widget _createBodyView() {
    if (_isLoadingData) {
      return const Center(
          child: CircularProgressIndicator(color: AppTheme.green800));
    }
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 32.h,
        vertical: 48.v,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context)!.profile_navigation_bar,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 34.v),
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              _user.fullname,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          InkWell(
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.v)),
            child: Padding(
              padding: EdgeInsets.only(left: 1.h, top: 15.v, bottom: 15.v),
              child: Text(
                _user.firebaseUser!.email!,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          InkWell(
            onTap: openEditProfileView,
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.v)),
            child: Padding(
              padding: EdgeInsets.only(left: 1.h, top: 15.v, bottom: 15.v),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/profile-user.png',
                    height: 41.adaptSize,
                    width: 41.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 19.h,
                      top: 7.v,
                      bottom: 8.v,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.edit_profile,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.v)),
            onTap: _openLanguageDialog,
            child: Padding(
              padding: EdgeInsets.only(left: 1.h, top: 15.v, bottom: 15.v),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/translation.png',
                    height: 41.adaptSize,
                    width: 41.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 21.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.language,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 2.v),
                        Text(
                          AppLocalizations.of(context)!.current_language,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: _openCurrencyDialog,
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.v)),
            child: Padding(
              padding: EdgeInsets.only(left: 1.h, top: 15.v, bottom: 15.v),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/change.png',
                    height: 41.adaptSize,
                    width: 41.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 21.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.currency,
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(_user.currency,
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: _changePassword,
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.v)),
            child: Padding(
              padding: EdgeInsets.only(left: 1.h, top: 15.v, bottom: 15.v),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/padlock.png',
                    height: 41.adaptSize,
                    width: 41.adaptSize,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 21.h, top: 10.v, bottom: 10.v),
                    child: Text(
                      AppLocalizations.of(context)!.change_password,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: _signOut,
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.v)),
            child: Padding(
              padding: EdgeInsets.only(left: 1.h, top: 15.v, bottom: 15.v),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logout.png',
                    height: 41.adaptSize,
                    width: 41.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 21.h),
                    child: Text(
                      AppLocalizations.of(context)!.log_out,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5.v),
        ],
      ),
    );
  }

  void _openCurrencyDialog() => showDialog(
      context: context,
      builder: (_) => CustomSelectableDialog(
              options: [
                Option(
                  "US Dollars (USD)",
                  "USD",
                ),
                Option(
                  "Đồng (VND)",
                  "VND",
                )
              ],
              initializeValue: _user.currency,
              onOptionSelect: (newCurrency) async {
                _user.currency = newCurrency!;
                await _presenter.updateUserInfo(_user);
                setState(() {});
              }));

  void _signOut() => showDialog(
      context: context,
      builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.v)),
            content: Text(AppLocalizations.of(context)!.log_out_confirm_msg,
                style: Theme.of(context).textTheme.bodyLarge),
            actions: [
              CustomElevatedButton(
                width: 70.h,
                text: AppLocalizations.of(context)!.log_out,
                buttonTextStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white),
                onPressed: _presenter.signOut,
              ),
              TextButton(
                  onPressed: Navigator.of(context, rootNavigator: true).pop,
                  child: Text(
                    AppLocalizations.of(context)!.cancel_btn,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppTheme.green800),
                  ))
            ],
          ));

  void _changePassword() {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) => InputEmailView(email: _user.firebaseUser!.email)));
  }

  @override
  void onLoadUserDataComplete(User user) {
    setState(() {
      _user = user;
      _isLoadingData = false;
    });
  }

  @override
  void onLoadUserDataFailed(FirebaseException e) {
    switch (e.code) {
      case 'network-request-failed':
        _showAlertDialog(AppLocalizations.of(context)!.network_issue_msg, () {
          setState(() {
            _presenter.loadUserData();
          });
        });
        break;
      default:
        _showAlertDialog(
            AppLocalizations.of(context)!.unexpected_error_msg(e.code), () {
          setState(() {
            _presenter.loadUserData();
          });
        });
        break;
    }
  }

  @override
  void onSignOutComplete() {
    context.go(LoginView.name);
  }

  void _openLanguageDialog() {
    var locales = AppLocalizations.supportedLocales;
    showDialog(
        context: context,
        builder: (_) => CustomSelectableDialog(
            options: List.generate(
                locales.length,
                (index) => Option(
                    AppLocalizations.of(context)!
                        .languageString(locales[index].languageCode),
                    locales[index])),
            initializeValue: ProfilePresenter().currentLocale,
            onOptionSelect: (value) =>
                ProfilePresenter().updateLocale(value!)));
  }

  void _showAlertDialog(String message, VoidCallback onConfirm) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.v)),
              content:
                  Text(message, style: Theme.of(context).textTheme.bodyMedium),
              actions: [
                CustomElevatedButton(
                  width: 70.h,
                  text: AppLocalizations.of(context)!.retry,
                  onPressed: onConfirm,
                ),
              ],
            ));
  }

  void openEditProfileView() {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) =>
            EditProfileView(_user.fullname, _user.firebaseUser!.email!)));
  }
}
