import 'dart:math';

import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/models/transaction_model.dart';
import 'package:budget_buddy/models/user_model.dart';
import 'package:budget_buddy/presenters/report_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/indicator.dart';
import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore_for_file: must_be_immutable
class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> implements ReportViewContract {
  late ReportPresenter _presenter;
  final incomeList = <Transaction>[];
  final expenseList = <Transaction>[];
  final incomeSpots = <FlSpot>[];
  final expenseSpots = <FlSpot>[];
  final dateList = <String>[];

  final colorList = [
    Colors.red.shade400,
    Colors.blue.shade400,
    Colors.orange.shade400,
    Colors.purple.shade400,
    Colors.green.shade400,
    Colors.brown.shade400,
    Colors.grey.shade400,
  ];

  late Map<String, MyCategory> categoryMap;

  final colorByCategoryId = <String, Color>{};

  final incomeColorMap = <Color, double>{};
  final expenseColorMap = <Color, double>{};
  // Map transaction according to categories
  late Map<String, List<Transaction>> incomeByCategoryMap;
  late Map<String, List<Transaction>> expenseByCategoryMap;
  late User user;
  double income = 0;
  double expense = 0;

  bool isLoading = true;

  final decimalFormat = NumberFormat.decimalPattern();
  late NumberFormat currencyFormat;

  late NumberFormat fullCurrencyFormat;

  @override
  void initState() {
    super.initState();
    _presenter = ReportPresenter(this);
    _presenter.loadData();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    if (isLoading) {
      return const Scaffold(
          body: Center(
              child: CircularProgressIndicator(color: AppTheme.green800)));
    }

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
                      top: 10.v,
                      bottom: 10.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.balance,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        SizedBox(height: 4.v),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            fullCurrencyFormat.format(user.balance),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 6.v),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!
                                .nearest_7_days
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20.v),

                        // Line chart
                        AspectRatio(
                          aspectRatio: 16.0 / 10.0,
                          child: LineChart(LineChartData(
                            lineTouchData: LineTouchData(enabled: false),
                            lineBarsData: [
                              LineChartBarData(
                                  spots: incomeSpots,
                                  color: Colors.green,
                                  dotData: FlDotData(show: false)),
                              LineChartBarData(
                                  spots: expenseSpots,
                                  color: Colors.red,
                                  dotData: FlDotData(show: false))
                            ],
                            maxY: incomeSpots.fold<double>(
                                0, (value, element) => max(element.y, value)),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      reservedSize: 50.h,
                                      showTitles: true,
                                      getTitlesWidget: getLeftTitleWidget)),
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      reservedSize: 60.v,
                                      showTitles: true,
                                      interval: 1,
                                      getTitlesWidget: getBottomTitleWidget)),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: false, reservedSize: 15.h),
                              ),
                            ),
                            gridData: FlGridData(show: false),
                          )),
                        ),

                        SizedBox(height: 14.v),
                        Padding(
                          padding: EdgeInsets.only(top: 10.v),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Indicator(
                                  color: Colors.green,
                                  text: AppLocalizations.of(context)!.income,
                                  isSquare: true),
                              SizedBox(width: 10.h),
                              Indicator(
                                  color: Colors.red,
                                  text: AppLocalizations.of(context)!.expense,
                                  isSquare: true)
                            ],
                          ),
                        ),
                        SizedBox(height: 10.v),
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
                          fullCurrencyFormat.format(income),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: AppTheme.green800,
                                  fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 23.v),
                        Container(
                          height: 109.v,
                          alignment: Alignment.center,
                          // Pie chart
                          child: PieChart(PieChartData(
                            startDegreeOffset: 90,
                            sectionsSpace: 0,
                            sections: getIncomeSectionList(),
                          )),
                        ),
                        SizedBox(height: 14.v),
                        // List view
                        _buildIncomeComponentList(context),

                        SizedBox(height: 14.v),
                        Text(
                          AppLocalizations.of(context)!.expense,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5.v),
                        Text(
                          fullCurrencyFormat.format(expense),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 23.v),
                        Container(
                          height: 109.adaptSize,
                          alignment: Alignment.center,
                          child: PieChart(PieChartData(
                            startDegreeOffset: 90,
                            sectionsSpace: 0,
                            sections: getExpenseSectionList(),
                          )),
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
        itemCount: incomeList.length,
        itemBuilder: (context, index) {
          return listItemWidget(context, incomeList[index]);
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
        itemCount: expenseList.length,
        itemBuilder: (context, index) {
          return listItemWidget(context, expenseList[index]);
        },
      ),
    );
  }

  Widget listItemWidget(BuildContext context, Transaction transaction) {
    return Padding(
      padding: EdgeInsets.only(
        left: 5.h,
        right: 5.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(7.h),
            child: Image.asset(
              categoryMap[transaction.categoryId]!.cImagePath,
              height: 35.adaptSize,
              width: 35.adaptSize,
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
              color: colorByCategoryId[transaction.categoryId],
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
              bottom: 6.v,
            ),
            child: Text(
              decimalFormat.format(transaction.amount),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: categoryMap[transaction.categoryId]!.isIncome
                      ? Colors.green
                      : Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLeftTitleWidget(double value, TitleMeta meta) {
    return Text(
      currencyFormat.format(value),
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  Widget getBottomTitleWidget(double value, TitleMeta meta) {
    if (value == 7) {
      return const Text('');
    }
    return Transform.translate(
      offset: Offset(10.h - value * 0.85, 20.v),
      child: Transform.rotate(
        angle: -pi * 45 / 180,
        child: Text(dateList[value.toInt()],
            style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }

  List<PieChartSectionData> getIncomeSectionList() =>
      List.generate(colorList.length, (index) {
        double percentage =
            (incomeColorMap[colorList[index]] ?? 0) / income * 100;
        return PieChartSectionData(
          title: '',
          value: percentage,
          radius: 54.adaptSize,
          color: colorList[index],
        );
      });

  List<PieChartSectionData> getExpenseSectionList() =>
      List.generate(colorList.length, (index) {
        double percentage =
            (incomeColorMap[colorList[index]] ?? 0) / income * 100;
        return PieChartSectionData(
          title: '',
          value: percentage,
          radius: 54.adaptSize,
          color: colorList[index],
        );
      });

  @override
  void onLoadDataError(FirebaseException exception) {
    // TODO: implement onLoadDataError
  }

  @override
  void onLoadDataSuccess(List<Transaction> transactionList,
      Map<String, MyCategory> categoryMap, User currentUser) {
    user = currentUser;
    var currencyLanguageCode = user.currency == 'VND' ? 'vi' : 'en';
    currencyFormat =
        NumberFormat.compactSimpleCurrency(locale: currencyLanguageCode);
    fullCurrencyFormat =
        NumberFormat.simpleCurrency(locale: currencyLanguageCode);

    this.categoryMap = categoryMap;

    for (var element in transactionList) {
      if (categoryMap[element.categoryId]!.isIncome) {
        incomeList.add(element);
      } else {
        expenseList.add(element);
      }
    }
    income = incomeList.fold(0, (total, element) => element.amount + total);
    expense = expenseList.fold(0, (total, element) => element.amount + total);

    var date = DateTime.now().subtract(const Duration(days: 7));
    var format = DateFormat('dd-MM-yy');
    for (int i = 0; i < 7; i++) {
      date = date.add(const Duration(days: 1));
      dateList.add(format.format(date));
    }

    incomeSpots.addAll(List.generate(
        7,
        (index) => FlSpot(
            index.toDouble(),
            incomeList.fold<double>(
                0,
                (value, element) => element.date == dateList[index]
                    ? value + element.amount
                    : value))));
    expenseSpots.addAll(List.generate(
        7,
        (index) => FlSpot(
            index.toDouble(),
            expenseList.fold<double>(
                0,
                (value, element) => element.date == dateList[index]
                    ? value + element.amount
                    : value))));

    incomeByCategoryMap = groupBy(incomeList, (t) => t.categoryId!);
    expenseByCategoryMap = groupBy(expenseList, (t) => t.categoryId!);

    for (int i = 0; i < incomeByCategoryMap.length; i++) {
      var total = incomeByCategoryMap.entries
          .elementAt(i)
          .value
          .fold<double>(0, (val, t) => val + t.amount);
      if (i < colorList.length) {
        incomeColorMap.addAll({colorList[i]: total});
        colorByCategoryId.addAll(
            {incomeByCategoryMap.entries.elementAt(i).key: colorList[i]});
      } else {
        incomeColorMap[colorList.last] =
            incomeColorMap[colorList.last]! + total;
        colorByCategoryId.addAll(
            {incomeByCategoryMap.entries.elementAt(i).key: colorList.last});
      }
    }

    for (int i = 0; i < expenseByCategoryMap.length; i++) {
      var total = expenseByCategoryMap.entries
          .elementAt(i)
          .value
          .fold<double>(0, (val, t) => val + t.amount);
      if (i < colorList.length) {
        expenseColorMap.addAll({colorList[i]: total});
        colorByCategoryId.addAll(
            {expenseByCategoryMap.entries.elementAt(i).key: colorList[i]});
      } else {
        expenseColorMap[colorList.last] =
            expenseColorMap[colorList.last]! + total;
        colorByCategoryId.addAll(
            {incomeByCategoryMap.entries.elementAt(i).key: colorList.last});
      }
    }

    setState(() => isLoading = false);
  }
}
