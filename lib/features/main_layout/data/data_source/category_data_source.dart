import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/features/main_layout/data/models/category_model.dart';
import 'package:movies_app/features/main_layout/data/models/movie_model.dart';
import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';

import '../../../../core/config/constants.dart';

abstract class BaseCategoryDataSource {
  Future<Either<String, List<CategoryData>>> getCategoryList();

  Future<Either<String, List<MovieData>>> getCategoryMoviesList(int categoryID);
}

class RemoteCategoryDataSource implements BaseCategoryDataSource {
  @override
  Future<Either<String, List<CategoryData>>> getCategoryList() async {
    final response = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/genre/movie/list?api_key=${Constants.apiKey}'),
    );

    if (response.statusCode == 200) {
      List<CategoryData> categoriesList = [];
      final data = json.decode(response.body);
      for (var e in List.from(data["genres"])){
        categoriesList.add(CategoryModel.fromJson(e));
      }

      List<Future<void>> fetchMoviesFuture = [];
      for (var e in categoriesList) {

        fetchMoviesFuture.add(
          getCategoryMoviesList(e.id).then(
            (res) {
              res.fold(
                (fail) {
                  return Left(fail);
                },
                (moviesList) {
                  e.image = moviesList[Random().nextInt(moviesList.length)].posterPath;
                  e.moviesList = moviesList;
                },
              );
            },
          ),
        );
      }
      await Future.wait(fetchMoviesFuture);
      return Right(categoriesList);
    } else {
      return Left(
          "Failed to load genres, ${response.statusCode}, ${response.toString()}");
    }
  }

  @override
  Future<Either<String, List<MovieData>>> getCategoryMoviesList(
      int categoryID) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/discover/movie?api_key=${Constants.apiKey}&with_genres=$categoryID'),
    );

    if (response.statusCode == 200) {
      List<MovieData> moviesList = [];
      final data = json.decode(response.body);
      for (var e in List.from(data["results"])) {
        moviesList.add(MovieModel.fromJson(e));
      }
      return Right(moviesList);
    } else {
      return Left(
          "Failed to get $categoryID movies, ${response.statusCode}, ${response.toString()}");
    }
  }
}
