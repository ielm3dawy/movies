import 'package:dartz/dartz.dart';

abstract class MovieTrailerRepositories{
  Future<Either<String, String>> getMovieTrailerUrl(int movieID);
}