import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';

class MovieModel extends MovieData {
  const MovieModel({
    required super.id,
    required super.adult,
    required super.language,
    required super.title,
    required super.posterPath,
    required super.overview,
    required super.releaseDate,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        adult: json["adult"],
        language: json["original_language"],
        title: json["title"],
        posterPath: json["poster_path"] ?? "",
        overview: json["overview"],
        releaseDate: json["release_date"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );
}
