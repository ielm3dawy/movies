import 'package:get_it/get_it.dart';
import 'package:movies_app/features/main_layout/data/data_source/category_data_source.dart';
import 'package:movies_app/features/main_layout/data/data_source/popular_movies_data_source.dart';
import 'package:movies_app/features/main_layout/data/repositories_Imp/category_repositories_imp.dart';
import 'package:movies_app/features/main_layout/data/repositories_Imp/movies_repositories_imp.dart';
import 'package:movies_app/features/main_layout/domain/repositories/categories_repositories.dart';
import 'package:movies_app/features/main_layout/domain/repositories/movies_repositories.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_category_use_case.dart';
import 'package:movies_app/features/main_layout/domain/use_cases/get_movies_use_case.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';

import '../../features/main_layout/data/data_source/top_rated_movies_data_source.dart';
import '../../features/main_layout/data/data_source/upcoming_movies_data_source.dart';

final sl = GetIt.instance;

void setup() {
  // Bloc Objects
  sl.registerFactory<MainLayoutCubit>(
    () => MainLayoutCubit(),
  );

  // Use Case
  sl.registerLazySingleton<GetCategoryUseCase>(
    () => GetCategoryUseCase(sl()),
  );
  sl.registerLazySingleton<GetMoviesUseCase>(
    () => GetMoviesUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<CategoriesRepositories>(
    () => CategoryRepositoriesImp(sl()),
  );
  sl.registerLazySingleton<MoviesRepositories>(
    () => MoviesRepositoriesImp(sl(), sl(), sl()),
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
}
