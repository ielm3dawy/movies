import 'package:dartz/dartz.dart';

import '../entities/movie_data.dart';

abstract class MovieRepositories{
  Future<Either<String, MovieData>> getMovie(int movieID);
}