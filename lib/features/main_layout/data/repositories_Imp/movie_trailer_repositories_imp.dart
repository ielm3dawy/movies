import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/data/data_source/movie_trailer_data_source.dart';
import 'package:movies_app/features/main_layout/domain/repositories/movie_trailer_repositories.dart';

class MovieTrailerRepositoriesImp implements MovieTrailerRepositories{

  final BaseMovieTrailerDataSource _baseMovieTrailerDataSource;

  MovieTrailerRepositoriesImp(this._baseMovieTrailerDataSource);

  @override
  Future<Either<String, String>> getMovieTrailerUrl(int movieID) async {
    return await _baseMovieTrailerDataSource.getMovieTrailerUrl(movieID);
  }
}