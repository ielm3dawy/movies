import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/color_palette.dart';
import '../../manager/search_cubit.dart';

class SearchTextField extends StatefulWidget {
  SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool isText = false;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      cursorColor: ColorPalette.primaryColor,
      style: const TextStyle(color: Colors.white),
      onChanged: (query) {
        context.read<SearchCubit>().getSearchMoviesList(query);
        setState(() {
          isText = query.trim().isNotEmpty;
        });
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: ColorPalette.primaryColor,
        ),
        suffixIcon: isText
            ? IconButton(
                onPressed: () {
                  context.read<SearchCubit>().getSearchMoviesList("");
                  _searchController.text = "";
                  isText = false;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.cancel,
                  color: ColorPalette.primaryColor,
                ),
              )
            : const SizedBox(
                width: 1,
              ),
        hintText: 'Search for a movie...',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPalette.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPalette.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPalette.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
