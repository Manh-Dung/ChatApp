part of 'movie_tab_cubit.dart';

// ignore: must_be_immutable
abstract class MovieTabState extends Equatable {
  const MovieTabState();
}

// ignore: must_be_immutable
class WaitingForWarmingUp extends MovieTabState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class WaitingForFetchingData extends MovieTabState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class WaitingForFetchingMoreData extends MovieTabState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DidAnythingFail extends MovieTabState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchingDataSuccessfully extends MovieTabState {
  List<Movie>? movies;
  int currentPage;
  int totalResults;
  int totalPages;
  bool canLoadMore;

  FetchingDataSuccessfully({
    this.movies,
    this.currentPage = 1,
    this.totalResults = 0,
    this.totalPages = 1,
    this.canLoadMore = true
  });

  @override
  List<Object> get props => [
    movies ?? [],
    currentPage,
    totalResults,
    totalPages,
  ];
}
