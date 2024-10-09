import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/page_route_names.dart';
import 'package:movies_app/features/main_layout/domain/entities/category_data.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_states.dart';
import '../../../../core/config/color_palette.dart';

class BrowseCategoriesScreen extends StatelessWidget {
  const BrowseCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
        builder: (context, state) {
      switch (state) {
        case InitializeMainLayoutState():
          return const Center(
            child: CircularProgressIndicator(color: ColorPalette.primaryColor,),
          );
        case ErrorMainLayoutState():
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(fontSize: 30, color: Colors.red),
            ),
          );
        case SuccessMainLayoutState():
          return _buildGenresGrid(
              context.read<MainLayoutCubit>().categoriesList);
      }
    });
  }

  Widget _buildGenresGrid(List<CategoryData> categoriesList) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.0 / 3.0,
      ),
      itemCount: categoriesList.length,
      itemBuilder: (context, index) {
        return _buildGenreItem(context, categoriesList[index]);
      },
    );
  }

  Widget _buildGenreItem(BuildContext context, CategoryData categoryData) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PageRouteNames.selectedCategoryScreen,
          arguments: categoryData,
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${categoryData.image}',
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(.6),
                    Colors.black.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              categoryData.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
