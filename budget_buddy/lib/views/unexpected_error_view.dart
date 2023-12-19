import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/material.dart';

class UnexpectedErrorView extends StatefulWidget {
  const UnexpectedErrorView({super.key});

  @override
  State<StatefulWidget> createState() => _UnexpectedErrorViewState();
}

class _UnexpectedErrorViewState extends State<UnexpectedErrorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 30.v, horizontal: 30.h),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.unexpected_error_view_title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AppTheme.green800),
                ),
                SizedBox(
                  height: 50.v,
                ),
                Text(
                  AppLocalizations.of(context)!.unexpected_error_view_body,
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            )));
  }
}
