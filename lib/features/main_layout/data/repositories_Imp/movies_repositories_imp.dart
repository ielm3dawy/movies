import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/data/data_source/popular_movies_data_source.dart';
import 'package:movies_app/features/main_layout/data/data_source/top_rated_movies_data_source.dart';
import 'package:movies_app/features/main_layout/data/data_source/upcoming_movies_data_source.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/repositories/movies_repositories.dart';

class MoviesRepositoriesImp extends MoviesRepositories {
  final BasePopularMoviesDataSource _basePopularMoviesDataSource;
  final BaseUpcomingMoviesDataSource _baseUpcomingMoviesDataSource;
  final BaseTopRatedMoviesDataSource _baseTopRatedMoviesDataSource;

  MoviesRepositoriesImp(
    this._basePopularMoviesDataSource,
    this._baseUpcomingMoviesDataSource,
    this._baseTopRatedMoviesDataSource,
  );

  @override
  Future<Either<String, List<MovieData>>> getPopularMoviesList() async {
    return await _basePopularMoviesDataSource.getPopularMoviesList();
  }

  @override
  Future<Either<String, List<MovieData>>> getUpcomingMoviesList() async {
    return await _baseUpcomingMoviesDataSource.getUpcomingMoviesList();
  }

  @override
  Future<Either<String, List<MovieData>>> getTopRatedMoviesList() async {
    return await _baseTopRatedMoviesDataSource.getTopRatedMoviesList();
  }
}
