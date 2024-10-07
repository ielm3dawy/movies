import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';

abstract class MoviesRepositories{
  Future<Either<String, List<MovieData>>> getPopularMoviesList();
  Future<Either<String, List<MovieData>>> getUpcomingMoviesList();
  Future<Either<String, List<MovieData>>> getTopRatedMoviesList();
}