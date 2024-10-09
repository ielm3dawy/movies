import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_category_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_movie_trailer_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_movies_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_watch_list_use_case.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/service_locator.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(InitializeMainLayoutState()) {
    getMoviesLists();
    getCategoriesList();
    loadWatchList();
  }

  int selectedCategoryIndex = 0;
  int focusedMovieIdx = 0;
  String focusedMovieTrailerUrl = "";
  List<CategoryData> _categoriesList = [];
  List<MovieData> popularMovies = [];
  List<MovieData> upcomingMovies = [];
  List<MovieData> topRatedMovies = [];
  List<MovieData> _watchListMovies = [];
  List<int> _watchListIDs = [];

  List<CategoryData> get categoriesList => _categoriesList;

  List<MovieData> get watchListMovies => _watchListMovies;

  void loading() {
    emit(InitializeMainLayoutState());
  }

  Future<void> getCategoriesList() async {
    final result = await sl<GetCategoryUseCase>().execute();

    return result.fold(
      (error) {
        emit(ErrorMainLayoutState(error));
      },
      (data) {
        _categoriesList = data;
      },
    );
  }

  Future<void> getMoviesLists() async {
    final result = await sl<GetMoviesUseCase>().execute();

    return result.fold(
      (error) {
        emit(ErrorMainLayoutState(error));
      },
      (moviesMap) async {
        popularMovies = moviesMap["popular"] ?? [];
        upcomingMovies = moviesMap["upcoming"] ?? [];
        topRatedMovies = moviesMap["topRated"] ?? [];
        focusedMovieIdx = Random().nextInt(20);
        final urlRes = await sl<GetMovieTrailerUseCase>().execute(popularMovies[focusedMovieIdx].id);
        urlRes.fold((error) {
          emit(ErrorMainLayoutState(error));
        }, (movieUrl) {
          focusedMovieTrailerUrl = movieUrl;
          emit(SuccessMainLayoutState());
        },);
      },
    );
  }

  Future<void> loadWatchList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = prefs.getStringList("watchList") ?? [];
    for (var e in data) {
      _watchListIDs.add(int.parse(e));
    }
    final res = await sl<GetWatchListUseCase>().execute(_watchListIDs);
    res.fold(
      (error) {
        emit(ErrorMainLayoutState(error));
      },
      (watchListMovies) {
        _watchListMovies = watchListMovies;
      },
    );
  }

  void addMovieToWatchlist(MovieData movie) async {
    _watchListMovies.add(movie);
    _watchListIDs.add(movie.id);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      "watchList",
      _watchListIDs.map((e) => e.toString()).toList(),
    );
  }

  void deleteMovieFromWatchList(MovieData movie) async {
    int idx = _watchListMovies.indexOf(movie);
    _watchListMovies.removeAt(idx);
    _watchListIDs.removeAt(idx);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      "watchList",
      _watchListIDs.map((e) => e.toString()).toList(),
    );
  }

  bool isInWatchlist(MovieData movie){
    int idx = _watchListMovies.indexOf(movie);
    return idx == -1 ? false : true;
  }
}
