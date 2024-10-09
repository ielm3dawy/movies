import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/page_route_names.dart';
import '../../domain/entities/movie_data.dart';
import '../manager/main_layout_cubit.dart';
import '../manager/movie_cubit.dart';

class MoviePoster extends StatefulWidget {
  final MovieData movie;
  final bool video;
  final double height;
  final double width;

  const MoviePoster({
    super.key,
    required this.movie,
    required this.height,
    required this.width,
    this.video = false,
  });

  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}';
    bool watchList = context.read<MainLayoutCubit>().isInWatchlist(widget.movie);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: widget.height,
        width: widget.width,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.video) {
                  context.read<MovieCubit>().youtubeController?.pause();
                }
                Navigator.pushNamed(
                    context, PageRouteNames.movieDetailedScreen,
                    arguments: widget.movie);
              },
              child: Container(
                // width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (watchList) {
                  context
                      .read<MainLayoutCubit>()
                      .deleteMovieFromWatchList(widget.movie);
                  watchList = false;
                } else {
                  context.read<MainLayoutCubit>().addMovieToWatchlist(widget.movie);
                  watchList = true;
                }
                setState(() {});
              },
              child: watchList
                  ? Image.asset(
                "assets/icons/checked_bookmark.png",
                scale: 2.5,
              )
                  : Image.asset(
                "assets/icons/bookmark.png",
                scale: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}