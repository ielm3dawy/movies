import 'package:dartz/dartz.dart';
import '../../../../core/config/constants.dart';
import '../../domain/entities/movie_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

abstract class BaseMovieDataSource {
  Future<Either<String, MovieData>> getMovie(int movieID);
}

class RemoteMovieDataSource implements BaseMovieDataSource {
  @override
  Future<Either<String, MovieData>> getMovie(int movieID) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/movie/$movieID?api_key=${Constants.apiKey}'),
    );

    if(response.statusCode == 200){
      var data = json.decode(response.body);
      MovieModel movie = MovieModel.fromJson(data);
      return Right(movie);
    } else {
      return Left("failed to get watchlist' movie: $movieID, ${response.statusCode}, ${response.body}");
    }
  }
}
