import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/data_sources/repositories/category_repository.dart';
class CategoryPresenter {
  final CategoryRepository _repository = CategoryRepository();
  void fetchCategories(String userID, Function(List<MyCategory>) onCategoriesFetched, Function(String) onError){
    _repository.fetchCategories(userID).listen((categories) {
      onCategoriesFetched(categories);}, onError: (error){
      onError("Error fetching categories: $error");
  });
  }
  Future<void> addCategories(
      MyCategory newCategory,
      Function() onCategoryAdded,
      Function(String) onError
      ) async {
    try {
      await _repository.addCategory(newCategory);
      onCategoryAdded();
    } catch (e){
      onError("Error adding category: $e");
    }
  }
}