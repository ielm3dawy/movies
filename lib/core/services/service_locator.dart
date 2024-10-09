import 'package:get_it/get_it.dart';
import 'package:movies_app/features/main_layout/data/data_source/category_data_source.dart';
import 'package:movies_app/features/main_layout/data/data_source/movie_data_source.dart';
import 'package:movies_app/features/main_layout/data/data_source/movie_trailer_data_source.dart';
import 'package:movies_app/features/main_layout/data/data_source/popular_movies_data_source.dart';
import 'package:movies_app/features/main_layout/data/data_source/search_movies_data_source.dart';
import 'package:movies_app/features/main_layout/data/data_source/similar_movies_data_source.dart';
import 'package:movies_app/features/main_layout/data/repositories_Imp/category_repositories_imp.dart';
import 'package:movies_app/features/main_layout/data/repositories_Imp/movie_trailer_repositories_imp.dart';
import 'package:movies_app/features/main_layout/data/repositories_Imp/movies_repositories_imp.dart';
import 'package:movies_app/features/main_layout/data/repositories_Imp/search_movies_repositories_imp.dart';
import 'package:movies_app/features/main_layout/data/repositories_Imp/similar_movies_repositories_imp.dart';
import 'package:movies_app/features/main_layout/data/repositories_Imp/watch_list_repositories_imp.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_data.dart';
import 'package:movies_app/features/main_layout/domain/repositories/categories_repositories.dart';
import 'package:movies_app/features/main_layout/domain/repositories/movies_repositories.dart';
import 'package:movies_app/features/main_layout/domain/repositories/search_movies_repositories.dart';
import 'package:movies_app/features/main_layout/domain/repositories/similar_movies_repositories.dart';
import 'package:movies_app/features/main_layout/domain/repositories/watch_list_repositories.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_category_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_movie_trailer_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_movies_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_search_movies_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_similar_movies_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_watch_list_use_case.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/manager/movie_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/manager/search_cubit.dart';

import '../../features/main_layout/data/data_source/top_rated_movies_data_source.dart';
import '../../features/main_layout/data/data_source/upcoming_movies_data_source.dart';
import '../../features/main_layout/domain/repositories/movie_trailer_repositories.dart';

final sl = GetIt.instance;

void setup() {
  // Bloc Objects
  sl.registerFactory<MainLayoutCubit>(
    () => MainLayoutCubit(),
  );
  sl.registerFactory<SearchCubit>(
    () => SearchCubit(),
  );
  sl.registerFactoryParam<MovieCubit, MovieData, void>(
    (movieData, _) => MovieCubit(movieData: movieData),
  );

  // Use Case
  sl.registerLazySingleton<GetCategoryUseCase>(
    () => GetCategoryUseCase(sl()),
  );
  sl.registerLazySingleton<GetMoviesUseCase>(
    () => GetMoviesUseCase(sl()),
  );
  sl.registerLazySingleton<GetSearchMoviesUseCase>(
    () => GetSearchMoviesUseCase(sl()),
  );
  sl.registerLazySingleton<GetSimilarMoviesUseCase>(
    () => GetSimilarMoviesUseCase(sl()),
  );
  sl.registerLazySingleton<GetMovieTrailerUseCase>(
    () => GetMovieTrailerUseCase(sl()),
  );
  sl.registerLazySingleton<GetWatchListUseCase>(
    () => GetWatchListUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<CategoriesRepositories>(
    () => CategoryRepositoriesImp(sl()),
  );
  sl.registerLazySingleton<MoviesRepositories>(
    () => MoviesRepositoriesImp(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<SearchMoviesRepositories>(
    () => SearchMoviesRepositoriesImp(sl()),
  );
  sl.registerLazySingleton<SimilarMoviesRepositories>(
    () => SimilarMoviesRepositoriesImp(sl()),
  );
  sl.registerLazySingleton<MovieTrailerRepositories>(
    () => MovieTrailerRepositoriesImp(sl()),
  );
  sl.registerLazySingleton<WatchListRepositories>(
    () => WatchListRepositoriesImp(sl()),
  );

  // Date Source
  sl.registerLazySingleton<BaseCategoryDataSource>(
    () => RemoteCategoryDataSource(),
  );
  sl.registerLazySingleton<BasePopularMoviesDataSource>(
    () => RemotePopularMoviesDataSource(),
  );
  sl.registerLazySingleton<BaseUpcomingMoviesDataSource>(
    () => RemoteUpcomingMoviesDataSource(),
  );
  sl.registerLazySingleton<BaseTopRatedMoviesDataSource>(
    () => RemoteTopRatedMoviesDataSource(),
  );
  sl.registerLazySingleton<BaseSearchMoviesDataSource>(
    () => RemoteSearchMoviesDataSource(),
  );
  sl.registerLazySingleton<BaseSimilarMoviesDataSource>(
    () => RemoteSimilarMoviesDataSource(),
  );
  sl.registerLazySingleton<BaseMovieTrailerDataSource>(
    () => RemoteMovieTrailerDataSource(),
  );
  sl.registerLazySingleton<BaseMovieDataSource>(
    () => RemoteMovieDataSource(),
  );
}
