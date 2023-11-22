import 'package:budget_buddy/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_bottom_bar.dart';

class MainNavigationView extends StatelessWidget {
  MainNavigationView({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        body: Navigator(
            key: navigatorKey,
            initialRoute: '/home',
            onGenerateRoute: (routeSetting) => PageRouteBuilder(
                pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
                transitionDuration: const Duration())),
        bottomNavigationBar: CustomBottomBar(onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
        }));
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.report:
        return "/report";
      case BottomBarEnum.budget:
        return "/budget";
      case BottomBarEnum.profile:
        return "/profile";
      default:
        return "/home";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case '/profile':
        return ProfileView();
      case '/report':
        return SizedBox();
      case '/budget':
        return SizedBox();
      default:
        return SizedBox();
    }
  }
}
