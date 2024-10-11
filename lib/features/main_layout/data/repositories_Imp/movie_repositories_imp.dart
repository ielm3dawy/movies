import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/data/data_source/movie_data_source.dart';

import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';

import '../../domain/repositories/movie_repositories.dart';

class MovieRepositoriesImp implements MovieRepositories{
  final BaseMovieDataSource _baseMovieDataSource;
  MovieRepositoriesImp(this._baseMovieDataSource);

  @override
  Future<Either<String, MovieData>> getMovie(int movieID) async {
    return await _baseMovieDataSource.getMovie(movieID);
  }

}