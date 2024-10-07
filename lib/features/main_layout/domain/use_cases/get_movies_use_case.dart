import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/repositories/movies_repositories.dart';

class GetMoviesUseCase {
  final MoviesRepositories _moviesRepositories;
  GetMoviesUseCase(this._moviesRepositories);

  Future<Either<String, Map<String, List<MovieData>>>> execute() async {

    Map<String, List<MovieData>> moviesMap = {};
    List<Future<void>> fetchMoviesLists = [];
    fetchMoviesLists.add(
      _moviesRepositories.getPopularMoviesList().then(
        (popularMoviesRes) {
          popularMoviesRes.fold(
            (fail) {
              return Left(fail);
            },
            (popularMoviesList) {
              moviesMap["popular"] = popularMoviesList;
            },
          );
        },
      ),
    );

    fetchMoviesLists.add(
      _moviesRepositories.getUpcomingMoviesList().then(
            (upcomingMoviesRes) {
          upcomingMoviesRes.fold(
                (fail) {
              return Left(fail);
            },
                (upcomingMoviesList) {
              moviesMap["upcoming"] = upcomingMoviesList;
            },
          );
        },
      ),
    );

    fetchMoviesLists.add(
      _moviesRepositories.getTopRatedMoviesList().then(
            (topRatedMoviesRes) {
          topRatedMoviesRes.fold(
                (fail) {
              return Left(fail);
            },
                (topRatedMoviesList) {
              moviesMap["topRated"] = topRatedMoviesList;
            },
          );
        },
      ),
    );
    
    await Future.wait(fetchMoviesLists);
    return Right(moviesMap);
  }
}
