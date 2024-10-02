import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'movie_details_screen.dart';

class MoviesListScreen extends StatefulWidget {
  final int genreId;
  final String genreName;

  MoviesListScreen({required this.genreId, required this.genreName});

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      final fetchedMovies = await apiService.fetchMoviesByGenre(widget.genreId);
      setState(() {
        movies = fetchedMovies;
      });
    } catch (e) {
      print('Error fetching movies by genre: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genreName, style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.black,
      ),
      body: movies.isEmpty
          ? Center(child: Text('No movies found', style: TextStyle(color: Colors.white)))
          : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final imageUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';

          return ListTile(
            leading: Image.network(imageUrl, width: 50, fit: BoxFit.cover),
            title: Text(movie['title'], style: TextStyle(color: Colors.white)),
            subtitle: Text('Release Date: ${movie['release_date']}', style: TextStyle(color: Colors.grey)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(movieId: movie['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}