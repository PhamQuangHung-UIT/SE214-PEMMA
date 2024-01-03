import 'package:budget_buddy/resources/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              SizedBox(height: 52.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 26.h,
                      right: 17.h,
                      bottom: 5.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "SỐ DƯ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        SizedBox(height: 4.v),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "9,999,250 đ",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(height: 6.v),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "BÁO CÁO 7 NGÀY GẦN NHẤT",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10.v),
                        SizedBox(height: 120.v),
                        SizedBox(height: 14.v),
                        Padding(
                          padding: EdgeInsets.only(left: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 29.h),
                              ),
                              Container(),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.v),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            AppLocalizations.of(context)!.expense,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 5.v),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "10,000,000",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: AppTheme.green800,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 23.v),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 109.v,
                            width: 114.h,
                            margin: EdgeInsets.only(right: 102.h),

                            // Pie chart
                            child: const Stack(
                                // TODO: implement pie chart
                                ),
                          ),
                        ),
                        SizedBox(height: 14.v),
                        // List view
                        _buildIncomeComponentList(context),
                        SizedBox(height: 14.v),
                        Text(
                          AppLocalizations.of(context)!.income,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5.v),
                        Text(
                          "10,000,000",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.red),
                        ),
                        SizedBox(height: 23.v),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 109.adaptSize,
                            width: 109.adaptSize,
                            child: Stack(
                                // TODO: implement pie chart
                                ),
                          ),
                        ),
                        SizedBox(height: 14.v),
                        _buildExpenseComponentList(context)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildIncomeComponentList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 33.h,
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            height: 13.v,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return listItemWidget(context);
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildExpenseComponentList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 33.h,
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            height: 13.v,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return listItemWidget(context);
        },
      ),
    );
  }

  Widget listItemWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.h,
        right: 33.h,
      ),
      child: Row(
        children: [
          Container(
            height: 35.adaptSize,
            width: 35.adaptSize,
            padding: EdgeInsets.all(7.h),
            child: Image.asset(
              'aaaaaaaaaaaaaaaaaaaaaaaaaaa',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 10.adaptSize,
            width: 10.adaptSize,
            margin: EdgeInsets.only(
              left: 9.h,
              top: 13.v,
              bottom: 12.v,
            ),
            decoration: BoxDecoration(
              color: const Color(0XFFFE8888),
              borderRadius: BorderRadius.circular(
                5.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5.h,
              top: 10.v,
              bottom: 6.v,
            ),
            child: Text(
              AppLocalizations.of(context)!.salary,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 10.v,
              bottom: 9.v,
            ),
            child: Text(
              "5,000,000",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
