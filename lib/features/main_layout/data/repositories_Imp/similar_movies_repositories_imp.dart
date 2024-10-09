import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/data/data_source/similar_movies_data_source.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/repositories/similar_movies_repositories.dart';

class SimilarMoviesRepositoriesImp implements SimilarMoviesRepositories{
  final BaseSimilarMoviesDataSource _baseSimilarMoviesDataSource;
  SimilarMoviesRepositoriesImp(this._baseSimilarMoviesDataSource);

  @override
  Future<Either<String, List<MovieData>>> getSimilarMoviesList(int movieID) async {
    return await _baseSimilarMoviesDataSource.getSimilarMoviesList(movieID);
  }
  
}