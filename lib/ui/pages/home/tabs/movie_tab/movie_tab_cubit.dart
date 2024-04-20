import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vinhcine/models/base/base_cubit.dart';
import 'package:vinhcine/repositories/movie_repository.dart';

import '../../../../../models/entities/movie.dart';

part 'movie_tab_state.dart';

class MovieTabCubit extends BaseCubit<MovieTabState> {
  MovieRepository repository;
  final messageController = PublishSubject<String>();

  MovieTabCubit({required this.repository})
      : super(WaitingForWarmingUp(), repository);

  Future<void> fetchMovieList({bool isReloaded = false}) async {
    if (!(state is FetchingDataSuccessfully) && !(state is WaitingForWarmingUp))
      return;

    FetchingDataSuccessfully currentState;

    /// combine data refreshing and data loading more function together
    if (state is WaitingForWarmingUp)
      currentState =
          FetchingDataSuccessfully(movies: List<Movie>.empty(growable: true));
    else
      currentState = state as FetchingDataSuccessfully;

    if (isReloaded)
      emit(WaitingForFetchingData());
    else
      emit(WaitingForFetchingMoreData());

    try {
      if (isReloaded) {
        currentState.currentPage = 1;
        currentState.canLoadMore = true;
      }

      if (currentState.canLoadMore != true) return;

      final response =
          await repository.getMovies(page: currentState.currentPage);

      if (isReloaded) {
        currentState.movies?.clear();
      }

      currentState.currentPage++;
      if (response?.results?.isNotEmpty == true) {
        currentState.movies?.addAll(response?.results ?? []);
        currentState.totalPages = response?.totalPages ?? 0;
      } else {
        currentState.canLoadMore = false;
      }

      emit(FetchingDataSuccessfully(
        movies: currentState.movies,
        currentPage: currentState.currentPage,
        totalResults: currentState.totalResults,
        totalPages: currentState.totalPages,
        canLoadMore: currentState.canLoadMore,
      ));
    } on Exception catch (e) {
      emit(DidAnythingFail());
    }
  }

  void addNewMovie() {
    try {
      if (!(state is FetchingDataSuccessfully)) return;
      FetchingDataSuccessfully currentState = state as FetchingDataSuccessfully;
      emit(WaitingForFetchingMoreData());
      currentState.movies?.add(
        Movie(
          id: DateTime.now().millisecondsSinceEpoch,
          backdropPath: "/sp7MPK2K60LLd7A6zjHKsfgjFil.jpg",
          posterPath: "/2lUYbD2C3XSuwqMUbDVDQuz9mqz.jpg",
          title: "The Devil Conspiracy 2",
          overview: "",
          voteAverage: 6.5,
          releaseDate: "2023-01-13",
        ),
      );
      emit(FetchingDataSuccessfully(
        movies: currentState.movies,
        currentPage: currentState.currentPage,
        totalResults: currentState.totalResults,
        totalPages: currentState.totalPages,
        canLoadMore: currentState.canLoadMore,
      ));
    } on Exception catch (e) {
      ///todo do something here
    }
  }

  bool deleteMovie(num id) {
    try {
      if (!(state is FetchingDataSuccessfully)) return false;
      FetchingDataSuccessfully currentState = state as FetchingDataSuccessfully;
      emit(WaitingForFetchingMoreData());
      int index =
          currentState.movies?.indexWhere((element) => element.id == id) ?? -1;
      if (index != -1) {
        currentState.movies?.removeAt(index);
        emit(FetchingDataSuccessfully(
          movies: currentState.movies,
          currentPage: currentState.currentPage,
          totalResults: currentState.totalResults,
          totalPages: currentState.totalPages,
          canLoadMore: currentState.canLoadMore,
        ));
        return true;
      }
      return false;
    } on Exception catch (e) {
      return false;
    }
  }

  @override
  Future<void> close() {
    messageController.close();
    return super.close();
  }
}
