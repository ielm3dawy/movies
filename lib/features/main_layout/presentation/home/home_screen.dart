import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_states.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../services (will be deleted)/api_service.dart';
import '../../../movie_screen/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    // _initializeVideoPlayer();
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

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state){
        switch(state){
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
            return ListView(
              padding: EdgeInsets.all(10),
              children: [
                // if (_youtubeController != null)
                //   YoutubePlayer(
                //     controller: _youtubeController!,
                //     showVideoProgressIndicator: true,
                //   )
                // else
                //   Center(child: CircularProgressIndicator()),

                MovieSection(title: 'Popular', movies: context.read<MainLayoutCubit>().popularMovies),
                SizedBox(height: 20),
                MovieSection(title: 'New Releases', movies: context.read<MainLayoutCubit>().upcomingMovies),
                SizedBox(height: 20),
                MovieSection(title: 'Recommended', movies: context.read<MainLayoutCubit>().topRatedMovies),
              ],
            );
        }
      },
    );
  }
}

class MovieSection extends StatelessWidget {
  final String title;
  final List<MovieData> movies;

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
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<MovieData> movies;

  MovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        final imageUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movieId: movie.id),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10),
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