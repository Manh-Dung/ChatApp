class EndPoints {
  EndPoints._();

  /// authen
  static const String refreshToken = "/auth/refreshToken";

  /// movie
  static const String discoverMovie = "/discover/movie";
  static const String movie = "/movie";
  static String movieDetail(num id) => "/movie/$id";
  static String similarMovie(num id) => "/movie/$id/similar";

  /// Setting
  static const String setting = "/settings";
}
