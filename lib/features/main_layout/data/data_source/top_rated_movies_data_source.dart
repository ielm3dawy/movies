import 'package:dartz/dartz.dart';
import 'package:movies_app/core/config/constants.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

abstract class BaseTopRatedMoviesDataSource {
  Future<Either<String, List<MovieData>>> getTopRatedMoviesList();
}

class RemoteTopRatedMoviesDataSource extends BaseTopRatedMoviesDataSource {
  @override
  Future<Either<String, List<MovieData>>> getTopRatedMoviesList() async {
    final response = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/movie/top_rated?api_key=${Constants.apiKey}'),
    );

    if (response.statusCode == 200) {
      List<MovieData> topRatedMoviesList = [];
      var data = json.decode(response.body);
      for (var e in List.from(data["results"])) {
        topRatedMoviesList.add(MovieModel.fromJson(e));
      }

      return Right(topRatedMoviesList);
    } else {
      return left(
          "Failed to get topRated movies list form api, ${response.statusCode}, ${response.toString()}");
    }
  }
}
