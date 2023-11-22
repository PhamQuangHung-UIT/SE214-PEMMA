import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ProfileView extends StatelessWidget {
  const ProfileView({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          child: Container(
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
                    "Profile",
                    style: AppTheme.lightTheme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 34.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Text(
                    "Tú Anh",
                    style: AppTheme.lightTheme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 7.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Text(
                    "email@gmail.com",
                    style: AppTheme.lightTheme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 25.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
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
                          "Edit profile",
                          style: AppTheme.lightTheme.textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
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
                              "Languages",
                              style: AppTheme.lightTheme.textTheme.titleLarge,
                            ),
                            SizedBox(height: 2.v),
                            Text(
                              "English",
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 21.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.v),
                  child: Align(
                    alignment: Alignment.center,
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
                              Text("Currency", style: AppTheme.lightTheme.textTheme.titleLarge),
                              Text("USD", style: AppTheme.lightTheme.textTheme.bodyMedium)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(right: 89.h),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/padlock.png',
                        height: 41.adaptSize,
                        width: 41.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 21.h),
                        child: Text(
                          "Change password",
                          style: AppTheme.lightTheme.textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
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
                          "Log out",
                          style: AppTheme.lightTheme.textTheme.titleLarge,
                        ),
                      ),
                    ],
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
