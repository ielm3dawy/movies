import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';

abstract class SimilarMoviesRepositories{
  Future<Either<String, List<MovieData>>> getSimilarMoviesList(int movieID);
}