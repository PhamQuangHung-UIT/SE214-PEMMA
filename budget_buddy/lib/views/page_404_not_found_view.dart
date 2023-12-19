import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/material.dart';

class Page404NotFoundView extends StatefulWidget {
  const Page404NotFoundView({super.key});

  @override
  State<StatefulWidget> createState() => _Page404NotFoundViewState();
}

class _Page404NotFoundViewState extends State<Page404NotFoundView> {
  @override
  Widget build(BuildContext context) {
    debugPrint(Uri.base.toString());
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 30.v, horizontal: 30.h),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.page_404_not_found_title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AppTheme.green800),
                ),
                SizedBox(
                  height: 50.v,
                ),
                Text(
                  AppLocalizations.of(context)!.page_404_not_found_body,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            )));
  }
}
