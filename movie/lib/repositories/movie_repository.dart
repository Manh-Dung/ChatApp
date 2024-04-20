import 'package:vinhcine/configs/app_config.dart';
import 'package:vinhcine/models/responses/array_response.dart';
import 'package:vinhcine/network/api_client.dart';

import '../models/entities/movie.dart';

abstract class MovieRepository {
  Future<ArrayResponse<Movie>>? getMovies({int page});

  Future<Movie> getMovie(num id);

  Future<ArrayResponse<Movie>> getSimilarMovies(num id, int? page);
}

class MovieRepositoryImpl extends MovieRepository {
  ApiClient? _apiClient;

  MovieRepositoryImpl(ApiClient? client) {
    _apiClient = client;
  }

  @override
  Future<Movie> getMovie(num id) async {
    try {
      return _apiClient!.getMovieDetail(id, MovieAPIConfig.APIKey);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<ArrayResponse<Movie>>? getMovies({int? page}) async {
    try {
      return _apiClient!.getMovies(MovieAPIConfig.APIKey, page ?? 1);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<ArrayResponse<Movie>> getSimilarMovies(num id, int? page) {
    try {
      return _apiClient!.getSimilarMovies(id, MovieAPIConfig.APIKey, page ?? 1);
    } catch (e) {
      throw e;
    }
  }
}
