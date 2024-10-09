import 'package:dartz/dartz.dart';
import 'package:movies_app/features/main_layout/domain/repositories/watch_list_repositories.dart';

import '../entities/movie_data.dart';

class GetWatchListUseCase{

  final WatchListRepositories _watchListRepositories;

  GetWatchListUseCase(this._watchListRepositories);

  Future<Either<String, List<MovieData>>> execute(List<int> watchListIDs) async{
    return await _watchListRepositories.getWatchList(watchListIDs);
  }
}