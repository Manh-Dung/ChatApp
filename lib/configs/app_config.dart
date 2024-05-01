import 'package:global_configuration/global_configuration.dart';

class AppConfig {
  static const String appId = 'it.thoson';
  static const String appName = 'Flutter Demo';
  static const String version = '1.0.0';

  /// APP CONFIG
  static final String APP_NAME = "-- FLUTTER BASE APP --";
  static final String TOKEN_STRING_KEY = 'TOKEN_STRING_KEY';
  static final String EMAIL_KEY = 'EMAIL_KEY';
  // static final String FCM_TOKEN_KEY = 'EMAIL_KEY';
  static final String ACCESS_TOKEN_KEY = 'ACCESS_TOKEN_KEY';
  static final String REFRESH_TOKEN_KEY = 'REFRESH_TOKEN_KEY';
  static final String USER_ID = 'USER_ID';
  static final String PASSWORD = 'PASSWORD';
  static final String USER_NAME = 'USER_NAME';
  static final String SEARCH_HISTORY = 'SEARCH_HISTORY';

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  ///Network
  static final baseUrl = "${GlobalConfiguration().getValue('baseUrl')}";

  /// Padding
  static final double paddingZero = 0.0;
  static final double paddingXS = 2.0;
  static final double paddingS = 4.0;
  static final double paddingM = 8.0;
  static final double paddingL = 16.0;
  static final double paddingXL = 32.0;
  static final double paddingXXL = 36.0;

  /// Margin
  static final double marginZero = 0.0;
  static final double marginXS = 2.0;
  static final double marginS = 4.0;
  static final double marginM = 8.0;
  static final double marginL = 16.0;
  static final double marginXL = 32.0;

  /// Spacing
  static final double spaceXS = 2.0;
  static final double spaceS = 4.0;
  static final double spaceM = 8.0;
  static final double spaceL = 16.0;
  static final double spaceXL = 32.0;
}

class FirebaseConfig {
  //Todo
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}

class MovieAPIConfig {
  static const String APIKey = 'fdec237ed56cb8462b2d225560650eb9';
}
