import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinhcine/repositories/movie_repository.dart';

import '../../../models/entities/movie.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({required this.repository}) : super(MovieDetailLoading());
  final MovieRepository repository;

  Future<void> getMovieById({required num id}) async {
    try {
      if (state is MovieDetailLoading) {
        emit(MovieDetailLoaded(
            movie: await repository.getMovie(id),
            listMovie: (await repository.getSimilarMovies(id, 1)).results));
      }
    } on Exception catch (e) {
      emit(MovieDetailError(e.toString()));
    }
  }
}
