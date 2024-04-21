import 'package:flutter/material.dart';
import 'package:vinhcine/utils/widgets/my_loading_image.dart';

import '../../../../models/entities/movie.dart';
import '../../../../network/constants/base_url.dart';
import '../../../../router/routers.dart';

class MovieDetailSimilar extends StatelessWidget {
  final List<Movie>? listMovie;
  final Movie? movie;

  const MovieDetailSimilar({super.key, required this.listMovie, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          listMovie?.length != 0
              ? Text("Similar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              : Container(),
          const SizedBox(height: 8),
          Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: (listMovie?.length ?? 0) > 0
                  ? ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        final movie = listMovie?[index];
                        return Container(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.movieDetail,
                                      arguments: {"movie": movie});
                                },
                                child: MyLoadingImage(
                                  borderRadius: 8,
                                  imageUrl: BaseUrl.imageUrl +
                                      (movie?.posterUrl ?? ""),
                                  size: 150,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Flexible(
                                child: Text(
                                  movie?.title ?? "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 8,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(width: 8),
                    )
                  : Container()),
        ],
      ),
    );
  }
}
