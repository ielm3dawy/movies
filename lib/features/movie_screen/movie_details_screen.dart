import 'package:flutter/material.dart';
import 'package:movies_app/core/config/color_palette.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../services (will be deleted)/api_service.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? movieDetails;
  List<dynamic> similarMovies = [];
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
    fetchSimilarMovies();
    _initializeVideoPlayer();
  }

  void fetchMovieDetails() async {
    try {
      final details = await apiService.fetchMovieDetails(widget.movieId);
      setState(() {
        movieDetails = details;
      });
    } catch (e) {
      print('Error fetching movie details: $e');
    }
  }

  void fetchSimilarMovies() async {
    try {
      final similar = await apiService.fetchSimilarMovies(widget.movieId);
      setState(() {
        similarMovies = similar;
      });
    } catch (e) {
      print('Error fetching similar movies: $e');
    }
  }

  void _initializeVideoPlayer() async {
    try {
      final trailerUrl = await apiService.fetchMovieVideo(widget.movieId);
      final videoId = YoutubePlayer.convertUrlToId(trailerUrl);

      if (videoId != null && videoId.isNotEmpty) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
        );
        setState(() {});
      } else {
        print('Invalid video ID');
      }
    } catch (e) {
      print('Error initializing video: $e');
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
        title: const Text('Movie Details', style: TextStyle(color: ColorPalette.primaryColor)),
        backgroundColor: Colors.black,
      ),
      body: movieDetails == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlayer(),
            _buildMovieDetails(),
            _buildSimilarMoviesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return _youtubeController != null
        ? YoutubePlayer(
      controller: _youtubeController!,
      showVideoProgressIndicator: true,
    )
        : Container(
      height: 200,
      color: Colors.grey,
      child: const Center(
        child: Text('No video available', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildMovieDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieDetails!['title'] ?? '',
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          RatingBar.builder(
            initialRating: movieDetails?['vote_average'] != null
                ? (movieDetails!['vote_average'] / 2)
                : 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 16,
            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {},
            ignoreGestures: true,
          ),
          const SizedBox(height: 10),
          Text(movieDetails!['overview'] ?? '', style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildSimilarMoviesSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('More Like This', style: TextStyle(color: ColorPalette.primaryColor, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildSimilarMoviesList(),
        ],
      ),
    );
  }

  Widget _buildSimilarMoviesList() {
    return similarMovies.isEmpty
        ? const Center(child: Text('No similar movies found', style: TextStyle(color: Colors.white)))
        : SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: similarMovies.length,
        itemBuilder: (context, index) {
          final movie = similarMovies[index];
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
              margin: const EdgeInsets.only(right: 10),
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}