import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Data/Model/movies_model.dart';

class DisplayMovies extends StatelessWidget {
  final List<Movie> moviesList;
  const DisplayMovies({
    required this.moviesList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(5),
            child: Divider(),
          );
        },
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100.h,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 4,
              child: Row(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    moviesList[index].image,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: 55.w,
                        height: 55.h,
                        child: Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        )),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Icon(Icons.broken_image)]),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                SizedBox(
                    width: 150.w, child: AutoSizeText(moviesList[index].title))
              ]),
            ),
          );
        },
        itemCount: moviesList.length,
      ),
    );
  }
}
