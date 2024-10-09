
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_movie_trailer_use_case.dart';
import 'package:movies_app/features/main_layout/presentation/manager/movie_states.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/use_cases/get_similar_movies_use_case.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit({required this.movieData}) : super(InitialMovieStates()) {
    loadData();
  }

  MovieData movieData;
  List<MovieData> _similarMoviesList = [];
  YoutubePlayerController? _youtubeController;

  List<MovieData> get similarMoviesList => _similarMoviesList;

  YoutubePlayerController? get youtubeController => _youtubeController;

  Future<void> loadData() async {
    final movieListResponse =
        await sl<GetSimilarMoviesUseCase>().execute(movieData.id);
    final movieTrailerResponse =
        await sl<GetMovieTrailerUseCase>().execute(movieData.id);

    movieListResponse.fold(
      (error) {
        emit(ErrorMovieStates(error));
        return Future.value();
      },
      (similarMoviesList) {
        _similarMoviesList = similarMoviesList;
      },
    );

    movieTrailerResponse.fold(
      (error) {
        emit(ErrorMovieStates(error));
        return Future.value();
      },
      (trailerUrl) {
        final videoId = YoutubePlayer.convertUrlToId(trailerUrl);
        if (videoId != null && videoId.isNotEmpty) {
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          );
        }
      },
    );

    emit(SuccessMovieStates());
  }
}
