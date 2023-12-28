import 'package:budget_buddy/views/add_transaction_view.dart';
import 'package:budget_buddy/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_bottom_bar.dart';

class MainNavigationView extends StatelessWidget {
  MainNavigationView({Key? key}) : super(key: key);

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: Scaffold(
            body: Navigator(
                key: navigatorKey,
                initialRoute: '/home',
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: const Duration(milliseconds: 300))),
            bottomNavigationBar: CustomBottomBar(onChanged: (type) {
              if (type == BottomBarEnum.add) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const AddTransactionView()));
              } else {
                navigatorKey.currentState!.pushNamed(getCurrentRoute(type));
              }
            })),
      ),
    ));
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
      default:
        return "/profile";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case '/home':
        return const ProfileView();
      case '/report':
        return const ProfileView();
      case '/budget':
        return const ProfileView();
      default:
        return const ProfileView();
    }
  }
}
