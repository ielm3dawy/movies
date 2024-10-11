import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/movie_poster.dart';

class MoviesVerticalSlideShow extends StatelessWidget {
  final List<MovieData> movies;
  final double height;

  const MoviesVerticalSlideShow({
    super.key,
    required this.movies,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(
          movie: movies[index],
          height: height,
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final MovieData movie;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          MoviePoster(
            movie: movie,
            height: height,
            width: height * 2 / 3.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  movie.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  movie.releaseDate,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(.67),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RatingBar.builder(
                  initialRating: movie.voteAverage / 2,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
