import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/presenters/category_presenter.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_category_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryView{
  void updateCategoryList(Stream<List<MyCategory>> categoryList){}
}
class CategoryComponent extends StatefulWidget {
  final CategoryContract presenter;
  const CategoryComponent(this.presenter, {super.key});

  @override
  State<CategoryComponent> createState() => _CategoryComponentState();
}
class _CategoryComponentState extends State<CategoryComponent> with SingleTickerProviderStateMixin implements CategoryView{
  late TabController _tabController;
  late Stream<List<MyCategory>> _stream;
  var db = FirebaseFirestore.instance.collection("categories").snapshots();
@override
void initState(){
  super.initState();
  //widget.presenter.categoryView = this;
  _tabController = TabController(length: 2, vsync: this);
}
@override
void dispose(){
  _tabController.dispose();
  super.dispose();
}
@override
void updateCategoryList(Stream<List<MyCategory>> categoryList){
    _stream = categoryList;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: AppTheme.lightTheme.colorScheme.background,
          appBar:  AppBar(
            centerTitle: true,
            title: Text('Categrories'),
          backgroundColor: Colors.green,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: 'Outcome'),
                  Tab(
                      text:'Income')
                ],
          ),
        ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Column(
                children: [
                  StreamBuilder(
                      stream: _stream,
                      builder:(context,snapshot){
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text("Loading");
                        }
                        List<MyCategory>? categories = snapshot.data!;
                        return ListView.builder(
                          itemCount: categories.length,
                            itemBuilder: (context,index){
                            if(!categories[index].isIncome){
                              return CustomCategoryWidget(
                                  CategoryName: categories[index].cName,
                                  ImagePath: categories[index].cImagePath,
                                  IsIncome: categories[index].isIncome);}
                            },
                        );
                      },
                  )
                ],
              ),
              Text('Hello')
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
