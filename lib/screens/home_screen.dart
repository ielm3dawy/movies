import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../services/api_service.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> popularMovies = [];
  List<dynamic> upcomingMovies = [];
  List<dynamic> topRatedMovies = [];
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    fetchMovies();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    try {
      final trailerUrl = await apiService.fetchMovieVideo(550);
      final videoId = YoutubePlayer.convertUrlToId(trailerUrl);
      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );
        setState(() {});
      }
    } catch (e) {
      print('Error initializing video: $e');
    }
  }

  void fetchMovies() async {
    try {
      final popular = await apiService.fetchPopularMovies();
      final upcoming = await apiService.fetchUpcomingMovies();
      final topRated = await apiService.fetchTopRatedMovies();

      setState(() {
        popularMovies = popular;
        upcomingMovies = upcoming;
        topRatedMovies = topRated;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Movies', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          if (_youtubeController != null)
            YoutubePlayer(
              controller: _youtubeController!,
              showVideoProgressIndicator: true,
            )
          else
            Center(child: CircularProgressIndicator()),

          MovieSection(title: 'Popular', movies: popularMovies),
          SizedBox(height: 20),
          MovieSection(title: 'New Releases', movies: upcomingMovies),
          SizedBox(height: 20),
          MovieSection(title: 'Recommended', movies: topRatedMovies),
        ],
      ),
    );
  }
}

class MovieSection extends StatelessWidget {
  final String title;
  final List<dynamic> movies;

  MovieSection({required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        SizedBox(height: 200, child: MovieList(movies: movies)),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<dynamic> movies;

  MovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        final imageUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movieId: movie['id']),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            width: 120,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}