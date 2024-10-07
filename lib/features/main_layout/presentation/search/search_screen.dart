import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/color_palette.dart';
import 'package:movies_app/core/config/color_palette.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_states.dart';
import '../../../../services (will be deleted)/api_service.dart';
import '../../../movie_screen/movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService apiService = ApiService();
  List<MovieData> searchResults = [];
  List<MovieData> suggestedMovies = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSuggestedMovies();
  }

  void fetchSuggestedMovies() async {
    try {
      // final suggestions = await apiService.fetchPopularMovies();
      setState(() {
        // suggestedMovies = suggestions;
      });
    } catch (e) {
      print('Error fetching suggested movies: $e');
    }
  }

  void searchMovies(String query) async {
    try {
      if (query.isNotEmpty) {
        final results = await apiService.searchMovies(query);
        setState(() {
          // searchResults = results;
        });
      } else {
        setState(() {
          searchResults = [];
        });
      }
    } catch (e) {
      print('Error searching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: searchMovies,
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                prefixIcon: const Icon(Icons.search, color: ColorPalette.primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MainLayoutCubit, MainLayoutState>(
              builder: (context, state) {
                if(searchResults.isNotEmpty){
                  return _buildMoviesList(searchResults);
                } else {
                  return _buildSuggestedMoviesList(context.read<MainLayoutCubit>().topRatedMovies);
                }
              },
            ),
          ),
        ],
      );
  }

  Widget _buildMoviesList(List<MovieData> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        final posterPath = movie.posterPath ?? '';
        final movieId = movie.id ?? 0;
        final movieTitle = movie.title ?? 'Unknown Title';

        if (movieId == 0) return Container();

        return ListTile(
          leading: posterPath.isNotEmpty
              ? Image.network(
            'https://image.tmdb.org/t/p/w92$posterPath',
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, color: Colors.white),
          )
              : const Icon(Icons.image_not_supported, color: Colors.white),
          title: Text(movieTitle, style: const TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movieId: movieId),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSuggestedMoviesList(List<MovieData> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Suggested Movies',
              style: TextStyle(
                  color: ColorPalette.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final posterPath = movie.posterPath ?? '';
              final movieId = movie.id ?? 0;

              if (movieId == 0) return Container();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(movieId: movieId),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: posterPath.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500$posterPath'),
                      fit: BoxFit.cover,
                    )
                        : null,
                    color: Colors.grey[800],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}