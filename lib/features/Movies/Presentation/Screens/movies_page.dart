import 'package:flutter/material.dart';
import 'package:pharmatask/features/Movies/Presentation/cubit/movies_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/display_movies_list.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top 250 Movies !"),elevation: 3,),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MoviesLoadedState) {
            return DisplayMovies(moviesList: state.moviesList);
          } else {
            return const Center(
              child: Text("Something wrong happend, please try again later"),
            );
          }
        },
      ),
    );
  }
}

