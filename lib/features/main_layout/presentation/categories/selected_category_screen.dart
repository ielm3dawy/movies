import 'package:flutter/material.dart';
import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';

import '../../../movie_screen/movie_details_screen.dart';

class SelectedCategoryScreen extends StatelessWidget {
  const SelectedCategoryScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    CategoryData categoryData = ModalRoute.of(context)!.settings.arguments as CategoryData;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryData.name,)
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: categoryData.moviesList.length,
        itemBuilder: (context, index) {
          final movie = categoryData.moviesList[index];
          final imageUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';

          return ListTile(
            leading: Image.network(imageUrl, width: 50, fit: BoxFit.cover),
            title: Text(
              movie.title,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Release Date: ${movie.releaseDate}',
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(movieId: movie.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
