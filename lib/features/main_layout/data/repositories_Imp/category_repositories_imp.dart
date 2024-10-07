import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/data/data_source/category_data_source.dart';
import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';
import 'package:movies_app/features/main_layout/domain/repositories/categories_repositories.dart';

class CategoryRepositoriesImp implements CategoriesRepositories{
  final BaseCategoryDataSource _baseCategoryDataSource;
  CategoryRepositoriesImp(this._baseCategoryDataSource);

  @override
  Future<Either<String, List<CategoryData>>> getCategoryDataList() {
    return _baseCategoryDataSource.getCategoryList();
  }

}