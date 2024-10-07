import 'package:equatable/equatable.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';

class CategoryData extends Equatable {
  final int id;
  final String name;
  late String image;
  List<MovieData> moviesList = [];

  CategoryData({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name, image];
}
