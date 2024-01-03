import 'package:budget_buddy/views/add_transaction_view.dart';
import 'package:budget_buddy/views/profile_view.dart';
import 'package:budget_buddy/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_bottom_bar.dart';
import 'package:go_router/go_router.dart';

class MainNavigationView extends StatefulWidget {
  final Widget child;

  final String path;

  const MainNavigationView(this.child, this.path, {Key? key}) : super(key: key);

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MainNavigationView> createState() => MainNavigationViewState();

  static final routeList = [
    GoRoute(
      path: '/home',
      builder: (_, state) => const HomeView(),
    ),
    GoRoute(
      path: '/report',
      builder: (_, state) => const ProfileView(),
    ),
    GoRoute(
      path: '/budget',
      builder: (_, state) => const ProfileView(),
    ),
    GoRoute(
      path: '/profile',
      builder: (_, state) => const ProfileView(),
    )
  ];
}

class MainNavigationViewState extends State<MainNavigationView> {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: Scaffold(
            body: widget.child,
            bottomNavigationBar:
                CustomBottomBar(getCurrentItem(widget.path), onChanged: (type) {
              if (type == BottomBarEnum.add) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AddTransactionView()));
              } else {
                MainNavigationView.navigatorKey.currentContext!
                    .go(getCurrentRoute(type));
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

  BottomBarEnum getCurrentItem(String path) => switch (path) {
        '/home' => BottomBarEnum.home,
        '/report' => BottomBarEnum.report,
        '/budget' => BottomBarEnum.budget,
        _ => BottomBarEnum.profile
      };
}
