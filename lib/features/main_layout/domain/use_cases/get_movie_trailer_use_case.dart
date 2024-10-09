import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/repositories/movie_trailer_repositories.dart';

class GetMovieTrailerUseCase {
  final MovieTrailerRepositories _movieTrailerRepositories;

  GetMovieTrailerUseCase(this._movieTrailerRepositories);

  Future<Either<String, String>> execute(int movieID) async {
    return await _movieTrailerRepositories.getMovieTrailerUrl(movieID);
  }
}
