import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/presenters/category_presenter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget_buddy/resources/app_export.dart';

class AddCategoryView extends StatefulWidget {
  MyCategory? existingCategory;
  AddCategoryView({super.key});
  AddCategoryView.existingCategory(MyCategory category, {super.key}){
    existingCategory = category;
  }
  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}
class _AddCategoryViewState extends State<AddCategoryView>{
  final CategoryPresenter _categoryPresenter = CategoryPresenter();
  late String userID;
  bool _isIncome = true;
  TextEditingController _cName = TextEditingController();
  List<String> iconIPList = [
    "assets/images/restaurant.png",
    "assets/images/fuel.png",
    "assets/images/plane.png",
    "assets/images/shopping-bag.png",
    "assets/images/wages.png"
  ];
  String _categoryIP = "assets/images/electricity-bill.png";
  @override
  void initState() {
    if(widget.existingCategory!= null){
      _cName.text = widget.existingCategory!.cName;
      _categoryIP = widget.existingCategory!.cImagePath;
      _isIncome = widget.existingCategory!.isIncome;
    }
    super.initState();
  }
  @override
  void dispose() {
    widget.existingCategory = null;
    super.dispose();
  }
  void _pressedAddCategory() {
    String uID = FirebaseAuth.instance.currentUser!.uid;
    String? cID;
    if(widget.existingCategory==null){
       cID = FirebaseFirestore.instance.collection('categories').doc().id;
    }
    else
      {
        cID = widget.existingCategory!.categoryID;
      }

    MyCategory newCategory = MyCategory(
        categoryID: cID,
        userID: uID,
        cName: _cName.value.text,
        cImagePath: _categoryIP,
        isIncome:_isIncome);
    addNewCategory(newCategory);
    print("Added new Category");
    Navigator.pop(context);
  }

  void addNewCategory(MyCategory newCategory) {
    _categoryPresenter.addCategories(newCategory,
            () => {},
            (error) => {
          //Xu li loi
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.lightTheme.colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Categories'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                icon: Image.asset('assets/images/check.png'),
                onPressed: _pressedAddCategory )
          ],
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppTheme.grey400,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(width: 1)),
                          padding: const EdgeInsets.all(10),
                          child: ImageIcon(
                            AssetImage(_categoryIP),
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: TextField(
                            controller: _cName,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            obscureText: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              labelText: 'Category name',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 100),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 2),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white
                        ),
                        child: DropdownButton(
                            items:const [
                              DropdownMenuItem(child: Text('Income'), value: true),
                              DropdownMenuItem(child: Text('Outcome'),value: false)
                            ],
                            value: _isIncome,
                            onChanged: (value){
                            setState(() {
                              _isIncome = value!;
                            });
                            },
                          style: TextStyle(
                            color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              )
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.grey400,
                  border: Border(top: BorderSide(color: Theme.of(context).dividerColor,width: 2)),
                ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text('Choose an icon for your category',
                      style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: iconIPList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1)),
                                child: IconButton(
                                  icon: Image.asset(iconIPList[index]), onPressed: () {
                                    setState(() {
                                      _categoryIP = iconIPList[index];
                                    });
                                },),
                                ),
                            );
                          }),
                  ])
              ),
            ),
          ],
        )
    );
  }
}
