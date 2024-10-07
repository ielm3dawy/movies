import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_category_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_movies_use_case.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_states.dart';

import '../../../../core/services/service_locator.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(InitializeMainLayoutState()) {
    getMoviesLists();
    getCategoriesList();

  }

  int selectedCategoryIndex = 0;
  List<CategoryData> _categoriesList = [];
  List<MovieData> popularMovies = [];
  List<MovieData> upcomingMovies = [];
  List<MovieData> topRatedMovies = [];

  List<CategoryData> get categoriesList => _categoriesList;

  Future<void> getCategoriesList() async {
    final result = await sl<GetCategoryUseCase>().execute();

    return result.fold(
      (error) {
        emit(ErrorMainLayoutState(error));
      },
      (data) {
        _categoriesList = data;
        emit(SuccessMainLayoutState());
      },
    );
  }

  Future<void> getMoviesLists() async {
    final result = await sl<GetMoviesUseCase>().execute();

    return result.fold(
      (error) {
        emit(ErrorMainLayoutState(error));
      },
      (moviesMap) {
        popularMovies = moviesMap["popular"] ?? [];
        upcomingMovies = moviesMap["upcoming"] ?? [];
        topRatedMovies = moviesMap["topRated"] ?? [];
        log(popularMovies.length.toString());
        log(upcomingMovies.length.toString());
        log(topRatedMovies.length.toString());
        emit(SuccessMainLayoutState());
      },
    );
  }
}
