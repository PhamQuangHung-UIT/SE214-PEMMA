import 'package:budget_buddy/views/add_budget_view.dart';
import 'package:budget_buddy/views/category_view.dart';
import 'package:budget_buddy/views/goal_budget_view.dart';
import 'package:budget_buddy/views/home_view.dart';
import 'package:budget_buddy/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_bottom_bar.dart';

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Navigator(
                initialRoute: '/home',
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: const Duration(milliseconds: 300))),
            bottomNavigationBar: CustomBottomBar(onChanged: (type) {
              Navigator.pushNamed(context, getCurrentRoute(type));
            })));
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.home:
        return "/home";
      case BottomBarEnum.report:
        return "/report";
      case BottomBarEnum.budget:
        return "/budget";
      case BottomBarEnum.profile:
        return "/profile";
      default:
        return "/new_transaction";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case '/home':
        return const HomeView();
      case '/report':
        return const ProfileView();
      case '/budget':
        return const ProfileView();
      case '/profile':
        return const ProfileView();
      default:
        return const ProfileView();
    }
  }
}
