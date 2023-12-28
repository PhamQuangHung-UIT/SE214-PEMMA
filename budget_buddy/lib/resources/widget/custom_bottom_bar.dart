import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key, this.onChanged});

  final Function(BottomBarEnum)? onChanged;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var bottomMenuList = [
      BottomMenuModel(
        icon: 'assets/images/home.png',
        activeIcon: 'assets/images/home-1.png',
        title: AppLocalizations.of(context)!.home_navigation_bar,
        type: BottomBarEnum.home,
      ),
      BottomMenuModel(
        icon: 'assets/images/bar-chart.png',
        activeIcon: 'assets/images/bar-chart-1.png',
        title: AppLocalizations.of(context)!.report_navigation_bar,
        type: BottomBarEnum.report,
      ),
      BottomMenuModel(
        icon: 'assets/images/plus.png',
        activeIcon: 'assets/images/plus.png',
        type: BottomBarEnum.add,
        isCircle: true,
      ),
      BottomMenuModel(
        icon: 'assets/images/money-bag.png',
        activeIcon: 'assets/images/money-bag-1.png',
        title: AppLocalizations.of(context)!.budget_navigation_bar,
        type: BottomBarEnum.budget,
      ),
      BottomMenuModel(
        icon: 'assets/images/avatar.png',
        activeIcon: 'assets/images/avatar-1.png',
        title: AppLocalizations.of(context)!.profile_navigation_bar,
        type: BottomBarEnum.profile,
      )
    ];
    
    return Container(
        height: 72.v,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.primary,
              spreadRadius: 2.h,
              blurRadius: 2.h,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          elevation: 0,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: List.generate(5, (index) {
            if (bottomMenuList[index].isCircle) {
              return BottomNavigationBarItem(
                icon: Image.asset(
                  bottomMenuList[index].icon,
                  height: 65.adaptSize,
                  width: 65.adaptSize,
                ),
                label: '',
              );
            }
            return BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    bottomMenuList[index].icon,
                    height: 31.adaptSize,
                    width: 31.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.v),
                    child: Text(
                      bottomMenuList[index].title ?? "",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              activeIcon: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    bottomMenuList[index].activeIcon,
                    height: 31.adaptSize,
                    width: 31.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.v),
                    child: Text(
                      bottomMenuList[index].title ?? "",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppTheme.green800,
                          ),
                    ),
                  ),
                ],
              ),
              label: '',
            );
          }),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            widget.onChanged?.call(bottomMenuList[index].type);
          },
        ),
    );
  }
}

enum BottomBarEnum { home, report, budget, profile, add }

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
    this.isCircle = false,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;

  bool isCircle;
}
