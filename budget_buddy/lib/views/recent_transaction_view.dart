import 'package:budget_buddy/models/transaction_model.dart' as model;
import 'package:budget_buddy/presenters/transaction_presenter.dart';
import 'package:budget_buddy/resources/widget/transaction_tile.dart';
import 'package:budget_buddy/views/home_view.dart';
import 'package:budget_buddy/views/main_navigation_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentTransaction extends StatefulWidget {
  const RecentTransaction({super.key});

  @override
  State<RecentTransaction> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  final TransactionPresenter _transactionPresenter = TransactionPresenter();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  List<model.Transaction> transactionList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    _transactionPresenter.fetchTransactions(
      userId,
      (transactions) {
        setState(() {
          transactionList.clear();
          transactionList.addAll(transactions);
        });
      },
      (error) {
        // Handle error when fetching goals
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white, size: 28.adaptSize),
            title: Text(
              AppLocalizations.of(context)!.recent_transaction_title,
              style: TextStyle(fontSize: 20.fSize, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Color(0xff03a700),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeView()));
              },
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: transactionList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.v),
                child: TransactionTile(transaction: transactionList[index]),
              );
            },
          )),
    );
  }
}
