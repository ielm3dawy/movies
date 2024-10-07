import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:movies_app/core/config/constants.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

abstract class BasePopularMoviesDataSource {
  Future<Either<String, List<MovieData>>> getPopularMoviesList();
}

class RemotePopularMoviesDataSource extends BasePopularMoviesDataSource {
  @override
  Future<Either<String, List<MovieData>>> getPopularMoviesList() async {
    final response = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/movie/popular?api_key=${Constants.apiKey}'),
    );
    log("hi");
    if (response.statusCode == 200) {
      List<MovieData> popularMoviesList = [];
      var data = json.decode(response.body);
      for (var e in List.from(data["results"])) {
        popularMoviesList.add(MovieModel.fromJson(e));
      }

      return Right(popularMoviesList);
    } else {
      return left(
          "Failed to get popular movies list form api, ${response.statusCode}, ${response.toString()}");
    }
  }
}
