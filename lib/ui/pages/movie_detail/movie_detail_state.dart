part of 'movie_detail_cubit.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailLoaded extends MovieDetailState {
  final Movie? movie;
  final List<Movie>? listMovie;

  MovieDetailLoaded({this.listMovie, this.movie});

  @override
  List<Object> get props => [movie ?? 0];
}

final class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}
