import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/repositories/similar_movies_repositories.dart';

class GetSimilarMoviesUseCase{
  final SimilarMoviesRepositories _similarMoviesRepositories;
  GetSimilarMoviesUseCase(this._similarMoviesRepositories);

  Future<Either<String, List<MovieData>>> execute(int movieID) async {
    return await _similarMoviesRepositories.getSimilarMoviesList(movieID);
  }
}