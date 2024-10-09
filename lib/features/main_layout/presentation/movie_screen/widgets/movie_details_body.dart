
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/features/main_layout/presentation/manager/movie_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/entities/movie_data.dart';
import '../../widgets/movies_slide_show.dart';

class MovieDetailsBody extends StatefulWidget {
  final MovieData movieData;

  const MovieDetailsBody({
    super.key,
    required this.movieData,
  });

  @override
  State<MovieDetailsBody> createState() => _MovieDetailsBodyState();
}

class _MovieDetailsBodyState extends State<MovieDetailsBody> {
  @override
  void dispose() {
    context.read<MovieCubit>().youtubeController?.pause();
    context.read<MovieCubit>().youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideoPlayer(),
          _buildMovieDetails(),
          MoviesSlideShow(
            title: "More Like This",
            movies: context.read<MovieCubit>().similarMoviesList,
            video: true,
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return context.read<MovieCubit>().youtubeController != null
        ? YoutubePlayer(
            controller: context.read<MovieCubit>().youtubeController!,
            showVideoProgressIndicator: true,
          )
        : Container(
            height: 200,
            color: Colors.grey,
            child: const Center(
              child: Text('No video available',
                  style: TextStyle(color: Colors.white)),
            ),
          );
  }

  Widget _buildMovieDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   movieData.title,
          //   style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 10),
          RatingBar.builder(
            initialRating: widget.movieData.voteAverage / 2,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 16,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {},
            ignoreGestures: true,
          ),
          const SizedBox(height: 10),
          Text(
            widget.movieData.overview,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
