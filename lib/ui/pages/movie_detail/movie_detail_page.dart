import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhcine/network/constants/base_url.dart';
import 'package:vinhcine/ui/pages/movie_detail/widgets/movie_detail_cast.dart';
import 'package:vinhcine/ui/pages/movie_detail/widgets/movie_detail_property.dart';
import 'package:vinhcine/ui/pages/movie_detail/widgets/movie_detail_rating.dart';
import 'package:vinhcine/ui/pages/movie_detail/widgets/movie_detail_tag.dart';

import '../../../configs/app_colors.dart';
import '../../../models/entities/movie.dart';
import '../../../router/routers.dart';
import '../../../utils/widgets/my_loading_image.dart';
import 'movie_detail_cubit.dart';
import 'widgets/movie_detail_similar.dart';

class MovieDetailPage extends StatelessWidget {
  MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<MovieDetailCubit>();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, Movie?>;
    final movieTemp = args['movie'];
    if (movieTemp != null) _cubit.getMovieById(id: movieTemp.id ?? 0);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        buildWhen: (prev, current) => current is MovieDetailLoaded,
        builder: (context, state) {
          if (state is MovieDetailError) return _buildError();
          if (state is MovieDetailLoading) return _buildLoading();
          final movie = (state as MovieDetailLoaded).movie;
          final listMovie = state.listMovie;
          return _buildMovieDetail(movie, context, listMovie);
        },
      ),
    );
  }

  Widget _buildError() => Scaffold(body: Center(child: Text("Error")));

  Widget _buildLoading() =>
      Scaffold(body: Center(child: CircularProgressIndicator()));

  Widget _buildMovieDetail(
          Movie? movie, BuildContext context, List<Movie>? listMovie) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(movie, context),
            const SizedBox(height: 24),
            _buildTags(movie),
            const SizedBox(height: 16),
            _buildProperties(movie),
            const SizedBox(height: 24),
            _buildDescription(movie),
            const SizedBox(height: 24),
            MovieDetailAvailable(),
            const SizedBox(height: 24),
            MovieDetailSimilar(listMovie: listMovie ?? [], movie: movie),
            const SizedBox(height: 24),
          ],
        ),
      );

  Widget _buildHeader(Movie? movie, BuildContext context) => Container(
        height: 410,
        child: Stack(
          children: [
            Container(
              height: 300,
              child: MyLoadingImage(
                  imageUrl: BaseUrl.imageUrl + (movie?.posterUrl ?? ""),
                  size: double.infinity),
            ),
            Positioned(top: 50, left: 20, child: _buildBackButton(context)),
            Positioned(top: 50, right: 15, child: _buildMoreButton(context)),
            Positioned(bottom: 0, child: _buildSubBanner(movie))
          ],
        ),
      );

  Widget _buildBackButton(BuildContext context) => InkWell(
      onTap: () => Navigator.pop(context),
      child: Icon(Icons.arrow_back_ios, color: Colors.white));

  Widget _buildMoreButton(BuildContext context) => InkWell(
      onTap: () => Navigator.popUntil(
          context, (route) => route.settings.name == Routers.home),
      child: Icon(Icons.home, color: Colors.white));

  Widget _buildSubBanner(Movie? movie) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: MyLoadingImage(
                      imageUrl: BaseUrl.imageUrl + (movie?.posterUrl ?? ""),
                      borderRadius: 10,
                      size: double.infinity),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 18),
                    Expanded(
                      child: Container(
                        width: 200,
                        child: Text(movie?.title ?? "Title",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Text(
                              _getYear(movie?.releaseDate ?? "Release date") +
                                  " - " +
                                  _convertTime(movie?.runtime ?? 0) +
                                  " - " +
                                  (movie?.originalLanguage == "en"
                                      ? "English"
                                      : "Vietnamese"),
                              style: TextStyle(
                                  fontSize: 15, color: AppColors.borderColor)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                        child: MovieDetailRating(
                            rating: movie?.voteAverage ?? 0.0)),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildTags(Movie? movie) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 18),
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                MovieDetailTag(tag: movie?.genres?[index].name ?? ""),
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: movie?.genres?.length ?? 0),
      );

  Widget _buildProperties(Movie? movie) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            MovieDetailProperty(
                tag: "Length", value: _convertTime(movie?.runtime ?? 0)),
            MovieDetailProperty(
                tag: "Language",
                value:
                    movie?.originalLanguage == "en" ? "English" : "Vietnamese"),
            MovieDetailProperty(
                tag: "Rating",
                value: (movie?.adult ?? false) ? "R" : "PG - 13"),
          ],
        ),
      );

  Widget _buildDescription(Movie? movie) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(movie?.overview ?? "Overview",
                style: TextStyle(fontSize: 12, color: AppColors.borderColor)),
          ],
        ),
      );

  String _convertTime(num time) {
    final hours = time ~/ 60;
    final minutes = time % 60;
    return "${hours}h ${minutes}min";
  }

  String _getYear(String releaseDate) {
    final date = DateTime.parse(releaseDate);
    return date.year.toString();
  }
}
