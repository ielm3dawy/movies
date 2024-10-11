import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/repositories/movie_repositories.dart';

import '../entities/movie_data.dart';

class GetWatchListUseCase {
  final MovieRepositories _movieRepositories;

  GetWatchListUseCase(this._movieRepositories);

  Future<Either<String, List<MovieData>>> execute(List<int> watchListIDs) async {
    try {
      final apiCalls = watchListIDs
          .map((movieID) => _movieRepositories.getMovie(movieID))
          .toList();

      final result = await Future.wait(apiCalls);

      List<MovieData> watchlist = [];
      for (var res in result) {
        res.fold(
          (error) {
            return Left(error);
          },
          (movie) {
            watchlist.add(movie);
          },
        );
      }
      return Right(watchlist);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
