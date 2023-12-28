import 'package:budget_buddy/presenters/add_transaction_presenter.dart';
import 'package:budget_buddy/presenters/profile_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({super.key});

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView>
    implements AddTransactionViewContract {
  String? dateText;

  String? timeText;

  final formatter = DateFormat('dd//MM/yyyy');

  final _amountController = TextEditingController(text: '500000');

  final _noteController = TextEditingController();

  late AddTransactionPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = AddTransactionPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.grey300,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildAppBar(context),
              Container(
                padding: EdgeInsets.all(14.h),
                child: Column(
                  children: [
                    _buildTransactionInfo(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppTheme.green800),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 20.v),
          AppBar(
            backgroundColor: AppTheme.green800,
            elevation: 0,
            toolbarHeight: 36.v,
            leadingWidth: 61.h,
            leading: Padding(
              padding: EdgeInsets.only(left: 25.h),
              child: InkWell(
                borderRadius: BorderRadius.circular(23.adaptSize),
                onTap: Navigator.of(context, rootNavigator: true).pop,
                child: Image.asset(
                  'assets/images/arrow-1.png',
                  width: 23.adaptSize,
                  height: 23.adaptSize,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.new_transaction,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            actions: [
              InkWell(
                onTap: onComplete,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(18.h, 3.v, 18.h, 4.v),
                    child: Image.asset(
                      'assets/images/check.png',
                      width: 23.adaptSize,
                      height: 23.adaptSize,
                      fit: BoxFit.cover,
                    )),
              ),
            ],
          ),
          SizedBox(height: 20.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 49.adaptSize,
                  width: 49.adaptSize,
                  padding: EdgeInsets.all(11.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.h),
                  ),
                  child: Image.asset(
                    'assets/images/restaurant.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // Input amount
                Padding(
                  padding: EdgeInsets.only(top: 7.v),
                  child: SizedBox(
                    width: 120.h,
                    child: TextField(
                      textAlign: TextAlign.right,
                      cursorColor: Colors.white,
                      controller: _amountController,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTransactionInfo(BuildContext context) {
    return Container(
      width: 359.h,
      margin: EdgeInsets.only(left: 3.h),
      padding: EdgeInsets.symmetric(
        horizontal: 23.h,
        vertical: 17.v,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1.h,
              blurRadius: 1.h,
              offset: const Offset(0, 4),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Date
          GestureDetector(
            onTap: _showPickDateDialog,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/calendar.png',
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.h,
                    top: 5.v,
                    bottom: 5.v,
                  ),
                  child: Text(
                    dateText ?? AppLocalizations.of(context)!.choose_date,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 19.v),

          // Time
          GestureDetector(
            onTap: _showPickTimeDialog,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/clock.png',
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.h,
                    top: 5.v,
                    bottom: 5.v,
                  ),
                  child: Text(
                    timeText ?? AppLocalizations.of(context)!.choose_time,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.v),

          // Note text field
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/notes.png',
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.h,
                      top: 5.v,
                      bottom: 5.v,
                    ),
                    child: TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.add_note,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppTheme.grey400),
                      ),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.v),
        ],
      ),
    );
  }

  void onComplete() {
    // Send new transaction to database
  }

  void _showPickDateDialog() {
    showDatePicker(
            context: context,
            // TODO: Replace this with the current date store in transaction model
            initialDate: DateTime.now(),
            firstDate: DateTime(1970),
            lastDate: DateTime.now(),
            confirmText: 'OK',
            cancelText: AppLocalizations.of(context)!.cancel_btn)
        .then((value) => value != null
            ? setState(() {
                // TODO: Assign the date value to transaction model
                //
                // Update the display text for date
                var now = DateTime.now();
                dateText = value.day == now.day &&
                        value.month == now.month &&
                        value.year == now.year
                    ? AppLocalizations.of(context)!.today
                    : formatter.format(value);
              })
            : {});
  }

  void _showPickTimeDialog() {
    showTimePicker(
            context: context,
            initialEntryMode: TimePickerEntryMode.input,

            // TODO: Replace this with the current date store in transaction model
            initialTime: TimeOfDay.now(),
            confirmText: 'OK',
            cancelText: AppLocalizations.of(context)!.cancel_btn)
        .then((value) => value != null
            ? setState(() {
                // TODO: Assign the time value to transaction model
                //
                // Update the display text for time
                timeText = value.format(context);
              })
            : {});
  }

  @override
  void onAddNewTransactionError(FirebaseException e) {
    // TODO: implement onAddNewTransactionError
  }

  @override
  void onAddNewTransactionSuccess() {
    // TODO: implement onAddNewTransactionSuccess
  }
}
