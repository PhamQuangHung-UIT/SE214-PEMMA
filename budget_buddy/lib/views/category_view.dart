import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_category_widget.dart';
import 'package:flutter/material.dart';
class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final items = <String> ['Food'];
@override
void initState(){
  super.initState();
  _tabController = TabController(length: 2, vsync: this);
}
@override
void dispose(){
  _tabController.dispose();
  super.dispose();
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
                    text: 'Outcome',),
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
                  Expanded(child: ListView.builder(
                    itemCount: items.length,
                      itemBuilder: (context,index){
                      return CustomCategoryWidget(
                        CategoryName: items[index],
                        ImagePath: 'assets/images/restaurant.png',
                        IsIncome: false,
                      );
                    }
                        )
                        )
                ],
              ),
              Text('Hello')
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
