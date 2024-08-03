import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vinhcine/models/responses/array_response.dart';
import 'package:vinhcine/network/constants/constant_urls.dart';

import '../models/entities/movie.dart';
import 'constants/endpoints.dart';


abstract class ApiClient {
  // factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  ///Setting
  @GET(EndPoints.setting)
  Future<void> getSetting();

  ///Auth

  /// Movie
  @GET(EndPoints.discoverMovie)
  Future<ArrayResponse<Movie>> getMovies(
      @Query('api_key') String apiKey, @Query('page') int page);

  @GET(EndPoints.movie)
  Future<Movie> getMovieDetail(
      @Path('movie_id') num id, @Query('api_key') String api_key);

  @GET(EndPoints.movie)
  Future<ArrayResponse<Movie>> getSimilarMovies(@Path('movie_id') num id,
      @Query('api_key') String api_key, @Query('page') int page);
}
