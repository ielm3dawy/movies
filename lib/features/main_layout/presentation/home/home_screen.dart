
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/color_palette.dart';
import 'package:movies_app/features/main_layout/presentation/home/widgets/focused_movie.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_states.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/movies_slide_show.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state){
        switch(state){
          case InitializeMainLayoutState():
            return const Center(
              child: CircularProgressIndicator(color: ColorPalette.primaryColor,),
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
              padding: const EdgeInsets.all(10),
              children: [
                FocusedMovie(movie: context.read<MainLayoutCubit>().popularMovies[context.read<MainLayoutCubit>().focusedMovieIdx]),
                MoviesSlideShow(title: 'Popular', movies: context.read<MainLayoutCubit>().popularMovies),
                const SizedBox(height: 20),
                MoviesSlideShow(title: 'New Releases', movies: context.read<MainLayoutCubit>().upcomingMovies),
                const SizedBox(height: 20),
                MoviesSlideShow(title: 'Recommended', movies: context.read<MainLayoutCubit>().topRatedMovies),
              ],
            );
        }
      },
    );
  }
}