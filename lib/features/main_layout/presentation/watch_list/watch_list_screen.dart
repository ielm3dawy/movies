import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/manager/main_layout_states.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/movies_vertical_slide_show.dart';

import '../../../../core/config/color_palette.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        switch (state) {
          case InitializeMainLayoutState():
            return const Center(
              child: CircularProgressIndicator(
                color: ColorPalette.primaryColor,
              ),
            );
          case ErrorMainLayoutState():
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(fontSize: 30, color: Colors.red),
              ),
            );

          case SuccessMainLayoutState():
            return MoviesVerticalSlideShow(
              movies: context.read<MainLayoutCubit>().watchListMovies,
              height: 180,
            );
        }
      },
    );
  }
}
