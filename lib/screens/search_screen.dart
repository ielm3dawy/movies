import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> searchResults = [];
  List<dynamic> suggestedMovies = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSuggestedMovies();
  }

  void fetchSuggestedMovies() async {
    try {
      final suggestions = await apiService.fetchPopularMovies();
      setState(() {
        suggestedMovies = suggestions;
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
          searchResults = results;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: searchMovies,
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                prefixIcon: Icon(Icons.search, color: Colors.yellow),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: searchResults.isNotEmpty
                ? _buildMoviesList(searchResults)
                : suggestedMovies.isNotEmpty
                ? _buildSuggestedMoviesList(suggestedMovies)
                : Center(
                child: Text('No movies found',
                    style: TextStyle(color: Colors.white))),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesList(List<dynamic> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        final posterPath = movie['poster_path'] ?? '';
        final movieId = movie['id'] ?? 0;
        final movieTitle = movie['title'] ?? 'Unknown Title';

        if (movieId == 0) return Container();

        return ListTile(
          leading: posterPath.isNotEmpty
              ? Image.network(
            'https://image.tmdb.org/t/p/w92$posterPath',
            errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, color: Colors.white),
          )
              : Icon(Icons.image_not_supported, color: Colors.white),
          title: Text(movieTitle, style: TextStyle(color: Colors.white)),
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

  Widget _buildSuggestedMoviesList(List<dynamic> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Suggested Movies',
              style: TextStyle(
                  color: Colors.yellow,
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
              final posterPath = movie['poster_path'] ?? '';
              final movieId = movie['id'] ?? 0;

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
                  margin: EdgeInsets.all(8.0),
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