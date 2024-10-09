import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/presentation/manager/search_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/manager/search_states.dart';
import 'package:movies_app/features/main_layout/presentation/search/widgets/search_text_field.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/movies_slide_show.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/movies_vertical_slide_show.dart';

import '../../manager/main_layout_cubit.dart';

class SearchBodyWidget extends StatelessWidget {
  const SearchBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchTextField(),
        ),
        Expanded(
          child: BlocBuilder<SearchCubit, SearchStates>(
            builder: (context, state) {
              switch (state) {
                case ErrorSearchState():
                  return Center(
                    child: Text(
                      state.error,
                      style: const TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  );

                case InitialSearchState():
                  return _buildSuggestedMoviesList(
                      context.read<MainLayoutCubit>().topRatedMovies);

                case SuccessSearchState():
                  return _buildMoviesList(
                      context.read<SearchCubit>().searchMoviesList);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMoviesList(List<MovieData> movies) {
    return MoviesVerticalSlideShow(movies: movies, height: 120,);
  }

  Widget _buildSuggestedMoviesList(List<MovieData> movies) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MoviesSlideShow(title: "Suggestions", movies: movies),
    );
  }
}
