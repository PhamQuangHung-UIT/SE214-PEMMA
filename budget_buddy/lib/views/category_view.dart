import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/presenters/category_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/views/add_category_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});
  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with SingleTickerProviderStateMixin {
  final CategoryPresenter _categoryPresenter = CategoryPresenter();
  late TabController _tabController;
  List<MyCategory> categoryList = [];
  List<MyCategory> cIncome = [];
  List<MyCategory> cOutcome = [];
  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userID = user.uid;
      _categoryPresenter.fetchCategories(
        userID,
        (categories) {
          setState(() {
            categoryList.clear();
            cIncome.clear();
            cOutcome.clear();
            categoryList.addAll(categories);
            for (int i = 0; i < categoryList.length; i++) {
              if (categoryList[i].isIncome) {
                cIncome.add(categoryList[i]);
              } else {
                cOutcome.add(categoryList[i]);
              }
            }
          });
        },
        (error) {
          //error when fetching goals
        },
      );
    } else {
      //user not logged im
    }
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.categories_title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff03a700),
        iconTheme: IconThemeData(color: Colors.white, size: 28),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
                text: AppLocalizations.of(context)!.categories_outcome +
                    '(${cOutcome.length.toString()})'),
            Tab(
                text: AppLocalizations.of(context)!.categories_income +
                    '(${cIncome.length.toString()})')
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          //Outcome
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cOutcome.length,
                  itemBuilder: (context, index) {
                    if (cOutcome.isNotEmpty) {
                      return CustomCategoryWidget(category: cOutcome[index]);
                    }
                  },
                ),
              )
            ],
          ),
          //Income
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cIncome.length,
                  itemBuilder: (context, index) {
                    if (cIncome.isNotEmpty) {
                      return CustomCategoryWidget(category: cIncome[index]);
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCategoryView()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomCategoryWidget extends StatelessWidget {
  final MyCategory category;

  const CustomCategoryWidget({super.key, required this.category});

  void _confirmDeleteCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.category_confirm_delete_title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(AppLocalizations.of(context)!.category_confirm_delete),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteCategory(context);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCategory(BuildContext context) {
    CategoryPresenter _categoryPresenter = CategoryPresenter();
    _categoryPresenter.deleteCategory(
      category.categoryID,
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.category_delete_successfull),
          ),
        );
      },
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.5), color: Colors.transparent),
      height: 60,
      child: Row(
        children: [
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              _confirmDeleteCategory(context);
            },
            child: const ImageIcon(
              AssetImage('assets/images/minus.png'),
              color: Colors.green,
              size: 15,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(width: 1)),
            padding: const EdgeInsets.all(7),
            child: ImageIcon(
              AssetImage(category.cImagePath),
              color: Colors.black,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Text(category.cName),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              widthFactor: 50,
              child: SizedBox(
                width: 30,
                height: 30,
                child: IconButton(
                  icon: Image.asset("assets/images/pen-1.png",
                      color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddCategoryView.existingCategory(category)));
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
    );
  }
}
