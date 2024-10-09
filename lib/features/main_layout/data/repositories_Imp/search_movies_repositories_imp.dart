import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/data/data_source/search_movies_data_source.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/repositories/search_movies_repositories.dart';

class SearchMoviesRepositoriesImp implements SearchMoviesRepositories{

  final BaseSearchMoviesDataSource _baseSearchMoviesDataSource;
  SearchMoviesRepositoriesImp(this._baseSearchMoviesDataSource);

  @override
  Future<Either<String, List<MovieData>>> getSearchMoviesList(String query) async {
    return await _baseSearchMoviesDataSource.getSearchMoviesList(query);
  }
}