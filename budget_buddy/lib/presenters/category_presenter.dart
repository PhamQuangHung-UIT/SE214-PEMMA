import 'package:budget_buddy/data_sources/repositories/category_repository.dart';
import 'package:budget_buddy/resources/app_export.dart';
import 'package:budget_buddy/resources/widget/custom_category_widget.dart';
import 'package:budget_buddy/views/category_view.dart';
import 'package:flutter/material.dart';
abstract class CategoryContract{
  //set categoryView(CategoryView value){}

}
class CategoryPresenter implements CategoryContract{
  late CategoryRepository _model;
  late CategoryView _view;
  CategoryPresenter(String userID){
    //_model = CategoryRepository(userID);
  }
}