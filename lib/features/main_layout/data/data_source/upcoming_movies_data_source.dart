import 'package:dartz/dartz.dart';
import 'package:movies_app/core/config/constants.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

abstract class BaseUpcomingMoviesDataSource {
  Future<Either<String, List<MovieData>>> getUpcomingMoviesList();
}

class RemoteUpcomingMoviesDataSource extends BaseUpcomingMoviesDataSource {
  @override
  Future<Either<String, List<MovieData>>> getUpcomingMoviesList() async {
    final response = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/movie/upcoming?api_key=${Constants.apiKey}'),
    );

    if (response.statusCode == 200) {
      List<MovieData> upcomingMoviesList = [];
      var data = json.decode(response.body);
      for (var e in List.from(data["results"])) {
        upcomingMoviesList.add(MovieModel.fromJson(e));
      }

      return Right(upcomingMoviesList);
    } else {
      return left(
          "Failed to get upcoming movies list form api, ${response.statusCode}, ${response.toString()}");
    }
  }
}

