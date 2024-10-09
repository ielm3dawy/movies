import 'package:flutter/material.dart';
import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/movies_vertical_slide_show.dart';


class SelectedCategoryScreen extends StatelessWidget {
  const SelectedCategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CategoryData categoryData =
        ModalRoute.of(context)!.settings.arguments as CategoryData;
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          title: Text(
            categoryData.name,
          )),
      body: MoviesVerticalSlideShow(
        movies: categoryData.moviesList,
        height: 140,
      ),
    );
  }
}
