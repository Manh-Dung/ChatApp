import 'package:vinhcine/database/preferences.dart';
import 'package:vinhcine/models/entities/index.dart';
import 'package:vinhcine/network/api_client.dart';

abstract class AuthRepository {
  Future<User?> getToken();

  Future<void> saveToken(User token);

  Future<void> removeToken();

  Future<User> signIn(String username, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient? _apiClient;

  AuthRepositoryImpl(ApiClient? client) {
    _apiClient = client;
  }

  @override
  Future<User?> getToken() async {
    final preferences = await Preferences.getInstance();
    return preferences.getToken();
  }

  @override
  Future<void> removeToken() async {
    final preferences = await Preferences.getInstance();
    return preferences.removeToken();
  }

  @override
  Future<void> saveToken(User token) async {
    final preferences = await Preferences.getInstance();
    return preferences.setToken(token);
  }

  @override
  Future<User> signIn(String username, String password) async {
    //Todo
    await Future.delayed(Duration(seconds: 2));
    return User(token: 'app_token', refreshToken: 'app_refresh_token');
  }
}
