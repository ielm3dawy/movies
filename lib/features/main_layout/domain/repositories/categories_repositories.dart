import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';

abstract class CategoriesRepositories{
  Future<Either<String, List<CategoryData>>> getCategoryDataList();
}