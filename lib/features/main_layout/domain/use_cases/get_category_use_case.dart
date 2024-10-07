import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/repositories/categories_repositories.dart';

import '../entities/category_data.dart';

class GetCategoryUseCase{
  final CategoriesRepositories _categoriesRepositories;
  GetCategoryUseCase(this._categoriesRepositories);

  Future<Either<String, List<CategoryData>>>  execute() async{
    return await _categoriesRepositories.getCategoryDataList();
  }

}