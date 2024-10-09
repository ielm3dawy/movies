import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/movie_poster.dart';

import '../manager/movie_cubit.dart';

class MoviesSlideShow extends StatelessWidget {
  final String title;
  final List<MovieData> movies;
  final bool video;

  const MoviesSlideShow({
    super.key,
    required this.title,
    required this.movies,
    this.video = false,
  });

  @override
  Widget build(BuildContext context) {
    // print("$title, length = ${movies.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MoviePoster(
                movie: movies[index],
                height: 200,
                width: 200 * 2 / 3.0,
              );
            },
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

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
