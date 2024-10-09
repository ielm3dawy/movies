import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/repositories/search_movies_repositories.dart';

class GetSearchMoviesUseCase {
  final SearchMoviesRepositories _searchMoviesRepositories;
  GetSearchMoviesUseCase(this._searchMoviesRepositories);

  Future<Either<String, List<MovieData>>> execute(String query) async {
    return await _searchMoviesRepositories.getSearchMoviesList(query);
  }
}