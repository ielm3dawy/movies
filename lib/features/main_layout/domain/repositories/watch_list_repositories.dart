import 'package:dartz/dartz.dart';

import '../entities/movie_data.dart';

abstract class WatchListRepositories{

  Future<Either<String, List<MovieData>>> getWatchList(List<int> watchListIDs);
}