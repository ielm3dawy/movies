import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/page_route_names.dart';
import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_states.dart';
import '../../../../services (will be deleted)/api_service.dart';
import 'selected_category_screen.dart';

class BrowseCategoriesScreen extends StatefulWidget {
  @override
  _BrowseCategoriesScreenState createState() => _BrowseCategoriesScreenState();
}

class _BrowseCategoriesScreenState extends State<BrowseCategoriesScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> genres = [];
  Map<int, String> genrePosters = {};

  @override
  void initState() {
    super.initState();
    _fetchGenresWithPosters();
  }

  void _fetchGenresWithPosters() async {
    try {
      final fetchedGenres = await apiService.fetchGenres();
      setState(() {
        genres = fetchedGenres;
      });
      _fetchAllGenrePosters(fetchedGenres);
    } catch (e) {
      print('Error fetching genres: $e');
    }
  }

  void _fetchAllGenrePosters(List<dynamic> fetchedGenres) {
    for (var genre in fetchedGenres) {
      _fetchGenrePoster(genre['id']);
    }
  }

  void _fetchGenrePoster(int genreId) async {
    try {
      final movies = await apiService.fetchMoviesByGenre(genreId);
      if (movies.isNotEmpty) {
        setState(() {
          genrePosters[genreId] = movies[10]['poster_path'];
        });
      }
    } catch (e) {
      print('Error fetching movies for genre $genreId: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
        builder: (context, state) {
      switch (state) {
        case InitializeMainLayoutState():
          return const Center(
            child: CircularProgressIndicator(),
          );
        case ErrorMainLayoutState():
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(fontSize: 30, color: Colors.red),
            ),
          );
        case SuccessMainLayoutState():
          return _buildGenresGrid(
              context.read<MainLayoutCubit>().categoriesList);
      }
    });
  }

  Widget _buildGenresGrid(List<CategoryData> categoriesList) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.0 / 3.0,
      ),
      itemCount: categoriesList.length,
      itemBuilder: (context, index) {
        return _buildGenreItem(categoriesList[index]);
      },
    );
  }

  Widget _buildGenreItem(CategoryData categoryData) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PageRouteNames.selectedCategoryScreen,
          arguments: categoryData,
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${categoryData.image}',
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(.6),
                    Colors.black.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              categoryData.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenrePoster(String? posterPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: posterPath != null
          ? Image.network(
              'https://image.tmdb.org/t/p/w500$posterPath',
              width: 120,
              height: 150,
              fit: BoxFit.cover,
            )
          : Container(
              width: 120,
              height: 150,
              color: Colors.grey,
            ),
    );
  }

  Widget _buildGenreName(String genreName) {
    return Text(
      genreName,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
