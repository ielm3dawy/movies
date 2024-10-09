import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/data/data_source/movie_data_source.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/repositories/watch_list_repositories.dart';

class WatchListRepositoriesImp implements WatchListRepositories{

  final BaseMovieDataSource _baseMovieDataSource;

  WatchListRepositoriesImp(this._baseMovieDataSource);

  @override
  Future<Either<String, List<MovieData>>> getWatchList(List<int> watchListIDs) async {
    List<MovieData> watchListMovies = [];
    for(var movieID in watchListIDs){
      final res = await _baseMovieDataSource.getMovie(movieID);
      res.fold((error){
        return Left(error);
      }, (movie) {
        watchListMovies.add(movie);
      },);
    }

    return Right(watchListMovies);
  }
}