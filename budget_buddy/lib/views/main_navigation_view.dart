import 'package:budget_buddy/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_bottom_bar.dart';

class MainNavigationView extends StatelessWidget {
  MainNavigationView({Key? key}) : super(key: key);

  final _pageController = PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        body: PageView(controller: _pageController, children: const [
          ProfileView(),
        ]),
        bottomNavigationBar: CustomBottomBar(onChanged: (BottomBarEnum type) {
          _pageController.animateToPage(getCurrentPage(type),
              duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
        }));
  }

  ///Handling route based on bottom click actions
  int getCurrentPage(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.report:
        return 1;
      case BottomBarEnum.budget:
        return 2;
      case BottomBarEnum.profile:
        return 3;
      default:
        return 0;
    }
  }
}
