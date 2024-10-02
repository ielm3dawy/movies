import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'movies_list_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Categories', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.black,
      ),
      body: genres.isEmpty
          ? _buildLoadingIndicator()
          : _buildGenresGrid(),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildGenresGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final genre = genres[index];
        final genreId = genre['id'];
        final genreName = genre['name'];
        final posterPath = genrePosters[genreId];
        return _buildGenreItem(genreId, genreName, posterPath);
      },
    );
  }

  Widget _buildGenreItem(int genreId, String genreName, String? posterPath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesListScreen(
              genreId: genreId,
              genreName: genreName,
            ),
          ),
        );
      },
      child: Column(
        children: [
          _buildGenrePoster(posterPath),
          SizedBox(height: 10),
          _buildGenreName(genreName),
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
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}