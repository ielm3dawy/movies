import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';

abstract class SearchMoviesRepositories{
  Future<Either<String, List<MovieData>>> getSearchMoviesList(String query);
}

