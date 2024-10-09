
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/color_palette.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/presentation/movie_screen/widgets/movie_details_body.dart';

import '../../../../core/services/service_locator.dart';
import '../manager/movie_cubit.dart';
import '../manager/movie_states.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieData movieData =
        ModalRoute.of(context)!.settings.arguments as MovieData;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          movieData.title,
          maxLines: 3,
          style: const TextStyle(
            fontSize: 22,
            color: ColorPalette.primaryColor,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<MovieCubit>(param1: movieData),
        child: BlocBuilder<MovieCubit, MovieStates>(
          builder: (context, state) {
            switch (state) {
              case InitialMovieStates():
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorPalette.primaryColor,
                  ),
                );
              case ErrorMovieStates():
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(fontSize: 30, color: Colors.red),
                  ),
                );
              case SuccessMovieStates():
                return MovieDetailsBody(movieData: movieData);
            }
          },
        ),
      ),
    );
  }
}
