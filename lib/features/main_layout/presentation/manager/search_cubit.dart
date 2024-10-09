import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_search_movies_use_case.dart';
import 'package:movies_app/features/main_layout/presentation/manager/search_states.dart';

import '../../../../core/services/service_locator.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  List<MovieData> _searchMoviesList = [];


  List<MovieData> get searchMoviesList => _searchMoviesList;

  void getSearchMoviesList(String query) async {
    query = query.trim();
    if (query.trim().isEmpty) {
      _searchMoviesList = [];
      emit(InitialSearchState());
      return;
    }
    final response = await sl<GetSearchMoviesUseCase>().execute(query);
    response.fold(
      (error) {
        emit(ErrorSearchState(error));
      },
      (searchMoviesList) {
        _searchMoviesList = searchMoviesList;
        emit(SuccessSearchState());
      },
    );
  }
}
