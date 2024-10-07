import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';

class CategoryModel extends CategoryData {
  CategoryModel({
    required super.id,
    required super.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
      );
}
