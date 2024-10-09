import 'package:dartz/dartz.dart';
import 'package:movies_app/core/config/constants.dart';
import 'package:movies_app/features/main_layout/data/models/movie_model.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class BaseSimilarMoviesDataSource{
  Future<Either<String, List<MovieData>>> getSimilarMoviesList(int movieID);
}

class RemoteSimilarMoviesDataSource implements BaseSimilarMoviesDataSource{
  @override
  Future<Either<String, List<MovieData>>> getSimilarMoviesList(int movieID) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/movie/$movieID/similar?api_key=${Constants.apiKey}'),
    );
    if(response.statusCode == 200){
      List<MovieData> similarMoviesList = [];
      var data = json.decode(response.body);
      for(var e in List.from(data["results"])){
        MovieData movie = MovieModel.fromJson(e);
        if(movie.posterPath.isNotEmpty) {
          similarMoviesList.add(movie);
        }
      }
      return Right(similarMoviesList);
    } else {
      return Left("fail to get similar movies list from api, ${response.statusCode}, ${response.body}");
    }
  }

}
